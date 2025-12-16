//
//  EventsMainView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

struct EventsMainView: View {
    
    @ObservedObject private var eventManager = EventManager.shared
    @State var isOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Upcoming Section
                    if !upcomingEvents.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Upcoming")
                                .font(.title2.bold())
                                .fontDesign(.serif)
                                .foregroundStyle(Color.amberGlow)
                                .padding(.horizontal)

                            ForEach(upcomingEvents) { event in
                                NavigationLink {
                                    EventDetailView(eventID: event.id)
                                } label: {
                                    EventCardView(
                                        event: event,
                                        isUpcoming: true
                                    )
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal)
                            }
                        }
                    }

                    // Past Section
                    if !pastEvents.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Past")
                                .font(.title2.bold())
                                .foregroundStyle(Color.amberGlow)
                                .padding(.horizontal)

                            ForEach(pastEvents) { event in
                                NavigationLink {
                                    EventDetailView(eventID: event.id)
                                } label: {
                                    EventCardView(
                                        event: event,
                                        isUpcoming: false
                                    )
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal)
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
