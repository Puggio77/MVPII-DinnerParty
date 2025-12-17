//
//  EventManagerModel.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 16/12/25.
//

import Foundation
import Combine
import CloudKit

@MainActor
class EventManager: ObservableObject {

    @Published var events: [Event] = []
    @Published var lastError: String = ""
    @Published var isLoading: Bool = false

    static let shared = EventManager()

    private let ck = CloudKitService.shared
    private var currentUserRecordName: String?
    private var currentDisplayName: String?

    private init() {
        Task {
            await bootstrapAndLoad()
        }
    }

    // Initial bootstrap: fetch user identity and load events
    private func bootstrapAndLoad() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let userRecordName = try await ck.fetchCurrentUserRecordName()
            self.currentUserRecordName = userRecordName
            self.currentDisplayName = await ck.fetchCurrentUserDisplayName()
            try await refresh()
        } catch {
            lastError = error.localizedDescription
        }
    }

    // MARK: - Event operations

    // Creates a new event and saves it to CloudKit
    func addEvent(_ event: Event) {
        Task {
            do {
                guard let userRecordName = currentUserRecordName else {
                    throw NSError(
                        domain: "CloudKit",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "iCloud user not available"]
                    )
                }

                let displayName = currentDisplayName ?? "You"
                try await ck.createEvent(
                    event: event,
                    hostDisplayName: displayName,
                    hostUserRecordName: userRecordName
                )
                try await refresh()
            } catch {
                lastError = error.localizedDescription
            }
        }
    }

    // Updates a local event instance
    // Currently used only for claimed challenges
    func updateEvent(_ event: Event) {
        // CloudKit sync for challenges will be added later
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
        }
    }

    // Removes an event locally
    // CloudKit deletion can be added if needed
    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }

    // Returns an event by its identifier
    func getEvent(by id: UUID) -> Event? {
        return events.first { $0.id == id }
    }

    // MARK: - CloudKit fetch

    // Refreshes all events for the current user from CloudKit
    func refresh() async throws {
        guard let userRecordName = currentUserRecordName else { return }

        isLoading = true
        defer { isLoading = false }

        let fetched = try await ck.fetchEventsForCurrentUser(userRecordName: userRecordName)
        self.events = fetched.sorted { $0.eventDateTime < $1.eventDateTime }
    }

    // MARK: - Deep link handling

    // Handles an incoming invite deep link and joins the related event
    func handleIncomingURL(_ url: URL) async -> UUID? {
        // Expected format: dinnerparty://join?code=XXXXXX
        guard url.scheme?.lowercased() == "dinnerparty" else { return nil }
        guard url.host?.lowercased() == "join" else { return nil }

        let comps = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let code = comps?.queryItems?.first(where: { $0.name.lowercased() == "code" })?.value

        guard let inviteCode = code, !inviteCode.isEmpty else { return nil }

        do {
            let userRecordName = try await ck.fetchCurrentUserRecordName()
            let displayName = await ck.fetchCurrentUserDisplayName()
            self.currentUserRecordName = userRecordName
            self.currentDisplayName = displayName

            let joinedEventID = try await ck.joinEvent(
                with: inviteCode,
                userRecordName: userRecordName,
                displayName: displayName
            )
            try await refresh()
            return joinedEventID
        } catch {
            lastError = error.localizedDescription
            return nil
        }
    }

    // MARK: - Invite links

    // Generates a CloudKit-backed invite link for an event
    func createInviteLink(for eventID: UUID) async throws -> URL {
        return try await ck.createInviteLink(for: eventID)
    }
}
