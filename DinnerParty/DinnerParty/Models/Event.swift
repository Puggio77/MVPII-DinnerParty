//
//  EventModel.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 10/12/25.
//

import Foundation

struct Event: Identifiable {
    
    var id: UUID = UUID()
    
    var eventName: String
    var eventDate: Date = Date()
    var eventTime: Date = Date()
    
    // Courses ids -
    var apetizers: Int
    var mainDishes: Int
    var desserts: Int
    var sideDishes: Int
    
    
    // Host and the invitees -
    var hostID: String
    var invitees: [String] = []
    
}
