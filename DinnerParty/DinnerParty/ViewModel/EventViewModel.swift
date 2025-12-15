//
//  EventViewModel.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 10/12/25.
//


import Foundation
import SwiftUI

@Observable
class EventViewModel {
    
    var events = [
        Event(title: "Friendsgiving Dinner",
              date: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
              time: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date()) ?? Date(),
              location: "Ana's Apartment",
              hostName: "Ana",
              appetizers: 2,
              mainDishes: 3,
              desserts: 2,
              sideDishes: 1)
    ]
    
    func addEvent (
                   title: String = "",
                   date: Date = Date(),
                   time: Date = Date(),
                   location: String = "",
                   hostName: String = "",
                   appetizers: Int = 0,
                   mainDishes: Int = 0,
                   desserts: Int = 0,
                   sideDishes: Int = 0) {
        let newEvent = Event(title: title, date: date, time: time, location: location, hostName: hostName, appetizers: appetizers, mainDishes: mainDishes, desserts: desserts, sideDishes: sideDishes)
        self.events.insert(newEvent, at: 0)
    }
}

