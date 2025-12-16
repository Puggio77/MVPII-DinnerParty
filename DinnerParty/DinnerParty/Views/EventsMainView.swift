//
//  EventsMainView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

import SwiftUI

struct EventsMainView: View {
    
    @ObservedObject private var eventManager = EventManager.shared
    @State var isOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Upcoming") {
                    ForEach(upcomingEvents) { event in
                        NavigationLink {
                            EventDetailView(eventID: event.id)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(event.title)
                                    .font(.headline)
                                Text(formatDate(event.eventDateTime))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                Section("Past Events") {
                    ForEach(pastEvents) { event in
                        NavigationLink {
                            EventDetailView(eventID: event.id)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(event.title)
                                    .font(.headline)
                                Text(formatDate(event.eventDateTime))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CreateEventView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private var upcomingEvents: [Event] {
        eventManager.events.filter { $0.eventDateTime > Date() }
            .sorted { $0.eventDateTime < $1.eventDateTime }
    }
    
    private var pastEvents: [Event] {
        eventManager.events.filter { $0.eventDateTime <= Date() }
            .sorted { $0.eventDateTime > $1.eventDateTime }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    EventsMainView()
}
