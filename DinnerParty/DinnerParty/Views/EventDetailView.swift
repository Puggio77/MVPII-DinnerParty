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

    private var availableCourses: [String] {
        guard let event = event else { return [] }
        
        var courses: [String] = []
        
        if event.appetizers > 0 { courses.append("Appetizers") }
        if event.mainDishes > 0 { courses.append("Main Dishes") }
        if event.desserts > 0 { courses.append("Desserts") }
        if event.sideDishes > 0 { courses.append("Side Dishes") }
        
        return courses
    }
    
    @State private var selectedCourse: String?

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
        .onAppear {
            if selectedCourse == nil {
                selectedCourse = availableCourses.first
            }
        }
    }
    
    @ViewBuilder
    private func eventContent(_ event: Event) -> some View {
        ZStack {
            Color(red: 0.94, green: 0.93, blue: 0.91)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // MARK: Event info section
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

                // MARK: Countdown Timer
                CountdownTimerView(eventDate: event.eventDateTime)
                    .padding(.top, 8)

                // MARK: course picker section
                Menu {
                    ForEach(availableCourses, id: \.self) { course in
                        Button(course) {
                            selectedCourse = course
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(selectedCourse ?? "Select Course")

                        Image(systemName: "chevron.up.chevron.down")
                    }
                    .foregroundColor(.primary)
                    .fontDesign(.serif)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                }
                .glassEffect(.regular.interactive())
                .padding(.top, 8)

    
                // MARK: Challenge cards TabView
                ChallengeCardsTabView(eventID: eventID, courseType: selectedCourse ?? "")
                    .frame(height: 460)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .padding(.top, -45)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
        }
    }

    //Format for the date and time
    private func formatEventDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d · h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    EventDetailView(eventID: Event.sampleEvent.id)
}
