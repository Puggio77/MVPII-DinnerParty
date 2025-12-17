//
//  EventModel.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 14/12/25.
//

import Foundation
import CloudKit

struct Event: Identifiable, Codable {
    let id: UUID
    var title: String
    var date: Date
    var time: Date
    var location: String
    var hostName: String
    
    // Course counts
    var appetizers: Int
    var mainDishes: Int
    var desserts: Int
    var sideDishes: Int
    
    // Claimed challenges grouped by course type
    var claimedChallenges: [String: [ClaimedChallenge]] = [:]
    
    // Computed property that combines date and time into a single Date
    var eventDateTime: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combined = DateComponents()
        combined.year = dateComponents.year
        combined.month = dateComponents.month
        combined.day = dateComponents.day
        combined.hour = timeComponents.hour
        combined.minute = timeComponents.minute
        
        return calendar.date(from: combined) ?? Date()
    }
    
    init(
        id: UUID = UUID(),
        title: String = "",
        date: Date = Date(),
        time: Date = Date(),
        location: String = "",
        hostName: String = "",
        appetizers: Int = 0,
        mainDishes: Int = 0,
        desserts: Int = 0,
        sideDishes: Int = 0
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.time = time
        self.location = location
        self.hostName = hostName
        self.appetizers = appetizers
        self.mainDishes = mainDishes
        self.desserts = desserts
        self.sideDishes = sideDishes
    }
    
    // Returns the number of dishes for a given course type
    func courseCount(for courseType: String) -> Int {
        switch courseType {
        case "Appetizers": return appetizers
        case "Main Dishes": return mainDishes
        case "Desserts": return desserts
        case "Side Dishes": return sideDishes
        default: return 0
        }
    }
}

// MARK: - Sample data for previews and testing
extension Event {
    static let sampleEvent = Event(
        title: "Friendsgiving Dinner",
        date: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
        time: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date()) ?? Date(),
        location: "Ana's Apartment",
        hostName: "Ana",
        appetizers: 2,
        mainDishes: 3,
        desserts: 2,
        sideDishes: 1
    )
}

// MARK: - CloudKit mapping
extension Event {

    // Initializes an Event from a CloudKit Event record
    init?(record: CKRecord) {
        guard
            let name = record[CKEventKeys.name] as? String,
            let location = record[CKEventKeys.location] as? String,
            let start = record[CKEventKeys.startDateTime] as? Date
        else { return nil }

        // The recordName is used as the UUID string
        let uuid = UUID(uuidString: record.recordID.recordName) ?? UUID()

        self.id = uuid
        self.title = name
        self.location = location
        self.hostName = "Host" // UI-only placeholder, can be improved later

        // Split the combined date into separate date and time values
        let cal = Calendar.current
        let dComp = cal.dateComponents([.year, .month, .day], from: start)
        let tComp = cal.dateComponents([.hour, .minute], from: start)

        self.date = cal.date(from: dComp) ?? start
        self.time = cal.date(from: tComp) ?? start

        // Course counts are merged later from CourseConfig
        self.appetizers = 0
        self.mainDishes = 0
        self.desserts = 0
        self.sideDishes = 0

        self.claimedChallenges = [:]
    }
}
