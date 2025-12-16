//
//  EventManagerModel.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 16/12/25.
//

import Foundation
import Combine

class EventManager: ObservableObject {
    
    @Published var events: [Event] = []
    
    static let shared = EventManager()
    
    private init() {
        loadEvents()
    }
    
    // MARK: - Event Operations
    
    func addEvent(_ event: Event) {
        events.append(event)
        saveEvents()
    }
    
    func updateEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
            saveEvents()
        }
    }
    
    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
        saveEvents()
    }
    
    func getEvent(by id: UUID) -> Event? {
        return events.first { $0.id == id }
    }
    
    // MARK: - Persistence (UserDefaults)
    
    private func saveEvents() {
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "savedEvents")
        }
    }
    
    private func loadEvents() {
        guard let data = UserDefaults.standard.data(forKey: "savedEvents"),
              let decoded = try? JSONDecoder().decode([Event].self, from: data) else {
            // If no saved events, use sample data for testing
            events = [Event.sampleEvent]
            return
        }
        events = decoded
    }
}
