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
    @State private var isSaving = false
    
    @State private var appetisers = 0
    @State private var mainDishes = 0
    @State private var dessert = 0
    @State private var sideDishes = 0

    // Formatter used to display the selected date and time
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    // Validates that all required fields are filled
    private var isFormValid: Bool {
        !eventTitle.isEmpty &&
        !eventLocation.isEmpty &&
        hasSelectedDate &&
        (appetisers > 0 || mainDishes > 0 || dessert > 0 || sideDishes > 0) &&
        !isSaving
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack(spacing: 20) {

                    // Event title input
                    TextField(
                        "",
                        text: $eventTitle,
                        prompt: Text("Event Title")
                            .foregroundStyle(.primary)
                    )
                    .font(.title3.bold())
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(in: Capsule())
                    .multilineTextAlignment(.center)

                    // Event location input
                    TextField(
                        "",
                        text: $eventLocation,
                        prompt: Text("Event Location")
                            .foregroundStyle(.primary)
                    )
                    .font(.title3.bold())
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(in: Capsule())
                    .multilineTextAlignment(.center)

                    // Date and time picker button
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
                        .padding(.vertical, 25)
                        .frame(maxWidth: .infinity)
                        .background(.amberGlow, in: Capsule())
                        .glassEffect(.regular.interactive(), in: .capsule)
                    }

                    // Courses configuration section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Courses")
                            .font(.title2.bold())
                            .foregroundStyle(.amberGlow)
                            .padding(.top, 8)

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

                    // Create event button
                    Button {
                        Task {
                            isSaving = true
                            createAndSaveEvent()
                            // EventManager saves the event to CloudKit asynchronously,
                            // so the view can be dismissed immediately for better UX.
                            isSaving = false
                        }
                    } label: {
                        Text(isSaving ? "Saving..." : "Add Event")
                            .font(.headline)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(isFormValid ? Color.amberGlow : Color.gray)
                            .clipShape(.capsule)
                            .glassEffect(.regular.interactive(), in: .capsule)
                    }
                    .disabled(!isFormValid)
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

    // Builds and saves a new event
    private func createAndSaveEvent() {
        let calendar = Calendar.current

        // Extract date and time components from the selected date
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedDate)

        // Create separate Date objects for date and time
        let eventDate = calendar.date(from: dateComponents) ?? Date()
        let eventTime = calendar.date(from: timeComponents) ?? Date()

        // Create the new Event model
        let newEvent = Event(
            title: eventTitle,
            date: eventDate,
            time: eventTime,
            location: eventLocation,
            hostName: "You", // UI-only placeholder
            appetizers: appetisers,
            mainDishes: mainDishes,
            desserts: dessert,
            sideDishes: sideDishes
        )

        // Save the event using the CloudKit-backed EventManager
        eventManager.addEvent(newEvent)

        // Dismiss the creation view
        dismiss()
    }
}

#Preview {
    CreateEventView()
}
