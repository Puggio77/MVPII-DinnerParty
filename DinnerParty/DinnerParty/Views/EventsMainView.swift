//
//  EventsMainView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

// Wrapper used to navigate after joining an event via deep link
private struct DeepLinkedEvent: Identifiable, Hashable {
    let id: UUID
}

struct EventsMainView: View {

    @ObservedObject private var eventManager = EventManager.shared
    @State private var deepLinkedEvent: DeepLinkedEvent?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Upcoming events section
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

                    // Past events section
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

            // Navigation triggered by a deep link join
            .navigationDestination(item: $deepLinkedEvent) { item in
                EventDetailView(eventID: item.id)
            }

            // Handle incoming invite links (dinnerparty://join?code=XXXX)
            .onOpenURL { url in
                Task {
                    if let joinedID = await eventManager.handleIncomingURL(url) {
                        deepLinkedEvent = DeepLinkedEvent(id: joinedID)
                    }
                }
            }

            // Pull to refresh events from CloudKit
            .refreshable {
                do {
                    try await eventManager.refresh()
                } catch {
                    // Errors are handled inside EventManager
                }
            }
        }
    }

    // Events happening in the future
    private var upcomingEvents: [Event] {
        eventManager.events
            .filter { $0.eventDateTime > Date() }
            .sorted { $0.eventDateTime < $1.eventDateTime }
    }

    // Events already finished
    private var pastEvents: [Event] {
        eventManager.events
            .filter { $0.eventDateTime <= Date() }
            .sorted { $0.eventDateTime > $1.eventDateTime }
    }

    // Date formatter (currently unused, kept for future use)
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    EventsMainView()
}
