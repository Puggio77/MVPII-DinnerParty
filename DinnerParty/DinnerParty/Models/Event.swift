//
//  EventModel.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 10/12/25.
//

import Foundation

struct Event: Identifiable, Codable {
    
    var id: UUID = UUID()
    
    var eventName: String
    var eventDate: Date = Date()
    
    // Courses ids -
    var apetizers: Int
    var mainDishes: Int
    var desserts: Int
    var sideDishes: Int
    
    
    // Host and the invitees -
    var hostID: String
    var invitees: [String] = []
    
}

extension Event {
    static var dummy = Event(eventName: "Bday Party", eventDate: Calendar.current.date(
        from: DateComponents(
            year: 2025,
            month: 12,
            day: 12,
            hour: 18,
            minute: 0
        )
    )!, apetizers: 2, mainDishes: 1, desserts: 1, sideDishes: 2, hostID: "Dummy Cover, replace with real host id", invitees: ["", ""])
}
