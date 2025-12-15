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
        Event(
            title: "Friendsgiving Dinner",
              date: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
              time: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date()) ?? Date(),
              location: "Ana's Apartment",
              hostName: "Ana",
              appetizers: 2,
              mainDishes: 3,
              desserts: 2,
              sideDishes: 1),
        Event(
            title: "Friendsgiving Dinner",
            date: Calendar.current.date(byAdding: .day, value: 5, to: Date())
            ?? Date(),
            time: Calendar.current.date(
                bySettingHour: 19,
                minute: 0,
                second: 0,
                of: Date()
            ) ?? Date(),
            location: "Ana's Apartment",
            hostName: "Ana",
            appetizers: 2,
            mainDishes: 3,
            desserts: 2,
            sideDishes: 1
        ),
        Event(
            title: "Galentines Brunch",
            date: Calendar.current.date(
                from: DateComponents(year: 2025, month: 2, day: 14)
            ) ?? Date(),
            time: Calendar.current.date(
                bySettingHour: 11,
                minute: 0,
                second: 0,
                of: Date()
            ) ?? Date(),
            location: "Café Milano",
            hostName: "Sarah",
            appetizers: 1,
            mainDishes: 2,
            desserts: 3,
            sideDishes: 0
        ),
        Event(
            title: "Ana's Birthday Lunch",
            date: Calendar.current.date(
                from: DateComponents(year: 2025, month: 1, day: 4)
            ) ?? Date(),
            time: Calendar.current.date(
                bySettingHour: 13,
                minute: 0,
                second: 0,
                of: Date()
            ) ?? Date(),
            location: "Rooftop Garden",
            hostName: "Mom",
            appetizers: 3,
            mainDishes: 2,
            desserts: 1,
            sideDishes: 2
        ),
        Event(
            title: "New Year's Dinner",
            date: Calendar.current.date(
                from: DateComponents(year: 2024, month: 12, day: 31)
            ) ?? Date(),
            time: Calendar.current.date(
                bySettingHour: 20,
                minute: 0,
                second: 0,
                of: Date()
            ) ?? Date(),
            location: "Downtown Loft",
            hostName: "Jake",
            appetizers: 4,
            mainDishes: 3,
            desserts: 2,
            sideDishes: 3
        ),
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

