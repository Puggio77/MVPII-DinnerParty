//
//  EventsMainView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

struct EventsMainView: View {
    @State var isOpen: Bool = false
    
    // MARK: Sample events, modify once data source is set up
    @State var events: [Event] = sampleEvents

    // Filter events into upcoming and past
    var upcomingEvents: [Event] {
        events.filter { $0.eventDateTime >= Date() }
    }

    var pastEvents: [Event] {
        events.filter { $0.eventDateTime < Date() }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Upcoming Section
                    if !upcomingEvents.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Upcoming")
                                .font(.title2.bold())
                                .foregroundStyle(Color.amberGlow)
                                .padding(.horizontal)

                            ForEach(upcomingEvents) { event in
                                NavigationLink {
                                    EventDetailView(event: event)
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
                                    EventDetailView(event: event)
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
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("My Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CreateEventView(EventVM: EventViewModel())
                    } label: {
                        Button("Done", systemImage: "plus") {

                        }
                    }

                }
            }
        }
    }
}

#Preview {
    EventsMainView()
}
