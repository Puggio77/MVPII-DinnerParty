//
//  EventDetailView.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import SwiftUI

struct EventDetailView: View {
    let eventID: UUID
    @ObservedObject private var eventManager = EventManager.shared
    
    // Retrieve the event from the shared manager
    private var event: Event? {
        eventManager.getEvent(by: eventID)
    }

    @State private var selectedCourse = "Main Course"
    private let courses = [
        "Main Course", "Starters", "Side Dishes", "Desserts", "Drinks"
    ]

    var body: some View {
        Group {
            if let event = event {
                eventContent(event)
            } else {
                Text("Event not found")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Event Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    InvitePeopleView(eventID: eventID)
                } label: {
                    Text("Invite")
                }
            }
        }
    }
    
    @ViewBuilder
    private func eventContent(_ event: Event) -> some View {
        ZStack {
            Color(red: 0.94, green: 0.93, blue: 0.91)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // Event information section
                VStack(spacing: 8) {
                    Text(event.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            Color(red: 0.25, green: 0.15, blue: 0.1)
                        )

                    Text(formatEventDateTime(event.eventDateTime))
                        .font(.title3.bold())
                        .foregroundColor(.secondary)

                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.headline)
                        Text(event.location)
                            .font(.title3)
                    }
                    .foregroundStyle(.secondary)
                }
                .fontDesign(.serif)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 16)

                // Countdown timer until the event starts
                CountdownTimerView(eventDate: event.eventDateTime)
                    .padding(.top, 8)

                // Course selection menu
                Menu {
                    ForEach(courses, id: \.self) { course in
                        Button(course) {
                            selectedCourse = course
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(selectedCourse)
                        Image(systemName: "chevron.up.chevron.down")
                    }
                    .foregroundColor(.primary)
                    .fontDesign(.serif)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                }
                .glassEffect(.regular.interactive())
                .padding(.top, 8)

                // Challenge card section
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white)
                    .overlay(
                        VStack(spacing: 24) {
                            Spacer()
                            Text("Draw a card to reveal the challenge")
                                .font(
                                    .system(
                                        size: 22,
                                        weight: .semibold,
                                        design: .serif
                                    )
                                )
                                .padding()
                                .multilineTextAlignment(.center)
                            Spacer()
                            NavigationLink {
                                DrawChallengeView(
                                    eventID: eventID,
                                    courseType: selectedCourse
                                )
                            } label: {
                                Text("Claim")
                                    .font(.headline)
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 100)
                                    .background(.amberGlow, in: .capsule)
                                    .foregroundColor(.white)
                                    .glassEffect(.regular.interactive())
                            }
                        }
                        .padding(.vertical, 32)
                    )
                    .frame(height: 350)
                    .padding(.horizontal, 8)

                // Page indicator dots (placeholder)
                // This will be replaced by a TabView in the future
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(
                                index == 1
                                    ? Color(
                                        red: 0.3,
                                        green: 0.25,
                                        blue: 0.2
                                    )
                                    : Color.gray.opacity(0.4)
                            )
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 8)

                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }

    // Formats the event date and time for display
    private func formatEventDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d · h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    EventDetailView(eventID: Event.sampleEvent.id)
}
