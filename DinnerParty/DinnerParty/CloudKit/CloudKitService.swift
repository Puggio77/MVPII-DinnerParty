//
//  CloudKitService.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 16/12/25.
//

import Foundation
import CloudKit

@MainActor
final class CloudKitService {
    static let shared = CloudKitService()

    private let container = CKContainer.default()
    private let publicDB: CKDatabase

    private init() {
        self.publicDB = container.publicCloudDatabase
    }

    // MARK: - Identity

    func fetchCurrentUserRecordName() async throws -> String {
        let id = try await container.userRecordID()
        return id.recordName
    }

    func fetchCurrentUserDisplayName() async -> String {
        do {
            let recordID = try await container.userRecordID()
            let participant = try await container.shareParticipant(forUserRecordID: recordID)

            if let comps = participant.userIdentity.nameComponents {
                let fmt = PersonNameComponentsFormatter()
                let name = fmt.string(from: comps)
                if !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return name
                }
            }
            return "Guest"
        } catch {
            return "Guest"
        }
    }

    // MARK: - Event + CourseConfig + Host Participant

    func createEvent(event: Event, hostDisplayName: String, hostUserRecordName: String) async throws {
        // Event record id = UUID dell'evento (stabile)
        let eventRecordID = CKRecord.ID(recordName: event.id.uuidString)
        let eventRecord = CKRecord(recordType: CKTypes.event, recordID: eventRecordID)

        eventRecord[CKEventKeys.name] = event.title as CKRecordValue
        eventRecord[CKEventKeys.location] = event.location as CKRecordValue
        eventRecord[CKEventKeys.startDateTime] = event.eventDateTime as CKRecordValue
        eventRecord[CKEventKeys.hostUserrecordName] = hostUserRecordName as CKRecordValue
        eventRecord[CKEventKeys.createdAt] = Date() as CKRecordValue

        // CourseConfig (1:1)
        let configRecordID = CKRecord.ID(recordName: "cfg_\(event.id.uuidString)")
        let config = CKRecord(recordType: CKTypes.courseConfig, recordID: configRecordID)
        let eventRef = CKRecord.Reference(recordID: eventRecordID, action: .none)

        config[CKCourseConfigKeys.eventRef] = eventRef
        config[CKCourseConfigKeys.appetizerCount] = Int64(event.appetizers) as CKRecordValue
        config[CKCourseConfigKeys.mainCount] = Int64(event.mainDishes) as CKRecordValue
        config[CKCourseConfigKeys.dessertCount] = Int64(event.desserts) as CKRecordValue
        config[CKCourseConfigKeys.sideCount] = Int64(event.sideDishes) as CKRecordValue

        // Participant host (idempotente)
        let participantRecordID = CKRecord.ID(recordName: "\(event.id.uuidString)_\(hostUserRecordName)")
        let participant = CKRecord(recordType: CKTypes.participant, recordID: participantRecordID)
        participant[CKParticipantKeys.eventRef] = eventRef
        participant[CKParticipantKeys.userIdentity] = hostUserRecordName as CKRecordValue
        participant[CKParticipantKeys.displayName] = hostDisplayName as CKRecordValue
        participant[CKParticipantKeys.joinedAt] = Date() as CKRecordValue

        // Save batch
        _ = try await publicDB.modifyRecords(saving: [eventRecord, config, participant], deleting: [])
    }

    // MARK: - Fetch events for current user (host OR participant)

    func fetchEventsForCurrentUser(userRecordName: String) async throws -> [Event] {
        var result: [UUID: Event] = [:]

        // 1) Events where I'm host
        do {
            let pred = NSPredicate(format: "\(CKEventKeys.hostUserrecordName) == %@", userRecordName)
            let q = CKQuery(recordType: CKTypes.event, predicate: pred)
            let (matchResults, _) = try await publicDB.records(matching: q)

            for (_, match) in matchResults {
                if case .success(let record) = match,
                   let event = Event(record: record) {
                    result[event.id] = event
                }
            }
        }

        // 2) Events where I'm participant (Participant -> eventRef -> fetch Event)
        var participantEventIDs: [CKRecord.ID] = []
        do {
            let pred = NSPredicate(format: "\(CKParticipantKeys.userIdentity) == %@", userRecordName)
            let q = CKQuery(recordType: CKTypes.participant, predicate: pred)
            let (matchResults, _) = try await publicDB.records(matching: q)

            for (_, match) in matchResults {
                if case .success(let record) = match,
                   let ref = record[CKParticipantKeys.eventRef] as? CKRecord.Reference {
                    participantEventIDs.append(ref.recordID)
                }
            }
        }

        if !participantEventIDs.isEmpty {
            // fetch in batch
            let fetched = try await publicDB.records(for: participantEventIDs)
            for (_, recResult) in fetched {
                if case .success(let record) = recResult,
                   let event = Event(record: record) {
                    result[event.id] = event
                }
            }
        }


        // 3) Load course configs and merge counts into Event
        let events = Array(result.values)
        let merged = try await attachCourseConfigs(to: events)

        return merged
    }

    private func attachCourseConfigs(to events: [Event]) async throws -> [Event] {
        guard !events.isEmpty else { return [] }

        // predicate: eventRef IN references
        let refs: [CKRecord.Reference] = events.map {
            CKRecord.Reference(recordID: CKRecord.ID(recordName: $0.id.uuidString), action: .none)
        }

        let pred = NSPredicate(format: "\(CKCourseConfigKeys.eventRef) IN %@", refs)
        let q = CKQuery(recordType: CKTypes.courseConfig, predicate: pred)

        let (matchResults, _) = try await publicDB.records(matching: q)

        // map eventID -> config
        var cfgByEventID: [UUID: CKRecord] = [:]
        for (_, match) in matchResults {
            if case .success(let record) = match,
               let ref = record[CKCourseConfigKeys.eventRef] as? CKRecord.Reference,
               let uuid = UUID(uuidString: ref.recordID.recordName) {
                cfgByEventID[uuid] = record
            }
        }

        // merge counts
        var out: [Event] = []
        out.reserveCapacity(events.count)

        for var e in events {
            if let cfg = cfgByEventID[e.id] {
                let a = (cfg[CKCourseConfigKeys.appetizerCount] as? Int64) ?? Int64(e.appetizers)
                let m = (cfg[CKCourseConfigKeys.mainCount] as? Int64) ?? Int64(e.mainDishes)
                let d = (cfg[CKCourseConfigKeys.dessertCount] as? Int64) ?? Int64(e.desserts)
                let s = (cfg[CKCourseConfigKeys.sideCount] as? Int64) ?? Int64(e.sideDishes)

                e.appetizers = Int(a)
                e.mainDishes = Int(m)
                e.desserts = Int(d)
                e.sideDishes = Int(s)
            }
            out.append(e)
        }
        return out
    }

    // MARK: - Invites (create link)

    func createInviteLink(for eventID: UUID) async throws -> URL {
        let code = Self.makeCode(length: 6)
        let url = URL(string: "dinnerparty://join?code=\(code)")!

        let record = CKRecord(recordType: CKTypes.inviteAlias)
        record[CKInviteAliasKeys.code] = code as CKRecordValue
        record[CKInviteAliasKeys.shareURL] = url.absoluteString as CKRecordValue
        record[CKInviteAliasKeys.createdAt] = Date() as CKRecordValue

        let ref = CKRecord.Reference(recordID: CKRecord.ID(recordName: eventID.uuidString), action: .none)
        record[CKInviteAliasKeys.eventRef] = ref

        _ = try await publicDB.save(record)
        return url
    }

    // MARK: - Join from code

    func joinEvent(with inviteCode: String, userRecordName: String, displayName: String) async throws -> UUID {
        // fetch InviteAlias by code
        let pred = NSPredicate(format: "\(CKInviteAliasKeys.code) == %@", inviteCode)
        let q = CKQuery(recordType: CKTypes.inviteAlias, predicate: pred)
        let (matchResults, _) = try await publicDB.records(matching: q)

        var eventID: UUID?

        for (_, match) in matchResults {
            if case .success(let record) = match,
               let ref = record[CKInviteAliasKeys.eventRef] as? CKRecord.Reference,
               let uuid = UUID(uuidString: ref.recordID.recordName) {
                eventID = uuid
                break
            }
        }

        guard let joinedEventID = eventID else {
            throw NSError(domain: "Invite", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invite code not found"])
        }

        // create participant (idempotente)
        let participantRecordID = CKRecord.ID(recordName: "\(joinedEventID.uuidString)_\(userRecordName)")
        let participant = CKRecord(recordType: CKTypes.participant, recordID: participantRecordID)

        let ref = CKRecord.Reference(recordID: CKRecord.ID(recordName: joinedEventID.uuidString), action: .none)
        participant[CKParticipantKeys.eventRef] = ref
        participant[CKParticipantKeys.userIdentity] = userRecordName as CKRecordValue
        participant[CKParticipantKeys.displayName] = displayName as CKRecordValue
        participant[CKParticipantKeys.joinedAt] = Date() as CKRecordValue

        // save (if exists, this will overwrite same id with same values)
        _ = try await publicDB.save(participant)
        return joinedEventID
    }

    // MARK: - Helpers

    private static func makeCode(length: Int) -> String {
        let chars = Array("ABCDEFGHJKLMNPQRSTUVWXYZ23456789") // no 0/O/1/I
        return String((0..<length).compactMap { _ in chars.randomElement() })
    }
}
