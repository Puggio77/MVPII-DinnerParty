//
//  CreateEventView.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 12/12/25.
//

import Foundation
import SwiftUI

struct CreateEventView: View {

    @ObservedObject private var eventManager = EventManager.shared
    @Environment(\.dismiss) var dismiss

    @State private var eventTitle = ""
    @State private var eventLocation = ""
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var hasSelectedDate = false

    @State private var appetisers = 0
    @State private var mainDishes = 0
    @State private var dessert = 0
    @State private var sideDishes = 0

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack(spacing: 15) {

                    // MARK: - Event Title Input
                    TextField(
                        "",
                        text: $eventTitle,
                        prompt: Text("Event Title")
                            .foregroundStyle(.primary)
                    )
                    .font(.title.bold())
                    .fontDesign(.serif)
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(in: Capsule())
                    .multilineTextAlignment(.center)

                    // MARK: - Location Input
                    TextField(
                        "",
                        text: $eventLocation,
                        prompt: Text("Event Location")
                            .foregroundStyle(.primary)
                    )
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(in: Capsule())
                    .multilineTextAlignment(.center)

                    // MARK: - Date Button
                    Button {
                        showDatePicker.toggle()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                            Text(
                                hasSelectedDate
                                    ? dateFormatter.string(from: selectedDate)
                                    : "Date and Time"
                            )
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(.amberGlow, in: Capsule())
                        .glassEffect(.regular.interactive(), in: .capsule)
                    }

                    // MARK: - Courses Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Courses")
                            .font(.title.bold())
                            .foregroundStyle(.black)
                        
                            .padding(.top, 8)
                            .fontDesign(.serif)

                        VStack(spacing: 12) {
                            CourseStepperView(title: "Appetizers", value: $appetisers)
                            CourseStepperView(title: "Main Dishes", value: $mainDishes)
                            CourseStepperView(title: "Desserts", value: $dessert)
                            CourseStepperView(title: "Side Dishes", value: $sideDishes)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }

                    Spacer()

                    // MARK: - Add Event Button
                    Button {
                        createAndNavigateToEvent()
                    } label: {
                        Text("Add Event")
                            .font(.headline)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(eventTitle.isEmpty ? Color.gray : .amberGlow)
                            .clipShape(.capsule)
                            .glassEffect(.regular.interactive(), in: .capsule)
                    }
                    .disabled(eventTitle.isEmpty)
                    .padding(.bottom, 20)
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
            }
            .navigationTitle("Create new event")
            
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(
                    selectedDate: $selectedDate,
                    isVisible: $showDatePicker
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .onDisappear {
                    hasSelectedDate = true
                }
            }
        }
    }

    // MARK: - Create Event Function
    private func createAndNavigateToEvent() {
        // Extract date and time components
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedDate)

        // Create separate Date objects for date and time
        let eventDate = calendar.date(from: dateComponents) ?? Date()
        let eventTime = calendar.date(from: timeComponents) ?? Date()

        // Create the new event
        let newEvent = Event(
            title: eventTitle,
            date: eventDate,
            time: eventTime,
            location: eventLocation.isEmpty ? "To be determined" : eventLocation,
            hostName: "You",  // TODO: Get from user profile
            appetizers: appetisers,
            mainDishes: mainDishes,
            desserts: dessert,
            sideDishes: sideDishes
        )

        // Add to event manager
        eventManager.addEvent(newEvent)

        // Dismiss view
        dismiss()
    }
}

#Preview {
    CreateEventView()
}
