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
    
    private var event: Event? {
        eventManager.getEvent(by: eventID)
    }
    
    @State private var selectedCourse = "Main Dishes"
    private let courses = ["Main Dishes", "Appetizers", "Side Dishes", "Desserts"]
    
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
    }
    
    @ViewBuilder
    private func eventContent(_ event: Event) -> some View {
        VStack(spacing: 24) {
            
            // MARK: Event info section
            VStack(spacing: 8) {
                Text(event.title)
                    .font(.title.bold())
                
                Text(formatEventDateTime(event.eventDateTime))
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(event.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 16)
            
            // MARK: Countdown Timer
            CountdownTimerView(eventDate: event.eventDateTime)
                .padding(.top, 8)
            
            // MARK: course picker section
            Picker("Course", selection: $selectedCourse) {
                ForEach(courses, id: \.self) { course in
                    Text(course).tag(course)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
            )
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .contentShape(Rectangle())
            .padding(.top, 8)
            
            // MARK: Challenge cards section (scrollable)
            ChallengeCardsScrollView(eventID: eventID, courseType: selectedCourse)
                .padding(.top, 8)
            
            NavigationLink {
                InvitePeopleView()
            } label: {
                Text("Invite more People")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .background(Color(.systemGroupedBackground))
    }
    
    private func formatEventDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d · h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    EventDetailView(eventID: Event.sampleEvent.id)
}
