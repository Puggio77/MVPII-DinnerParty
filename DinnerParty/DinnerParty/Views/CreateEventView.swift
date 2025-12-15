//
//  CreateEventView.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 12/12/25.
//

import Foundation
import SwiftUI

struct CreateEventView: View {

    @State private var eventTitle = ""
    @State private var showDatePicker = false
    @State private var selectedDate = Date()

    @State private var selectedTime = Date()

  
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

                VStack(spacing: 20) {

                    // MARK: - Event Title Input
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

                    // MARK: - Date Button
                    Button {
                        showDatePicker.toggle()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                            Text(
                                hasSelectedDate
                                    ? dateFormatter.string(
                                        from: selectedDate
                                    )
                                    : "Date and Time"
                            )

                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.vertical, 25)
                        .frame(maxWidth: .infinity).background(
                            .amberGlow,
                            in: Capsule()
                        )
                        .glassEffect(.regular.interactive(), in: .capsule)
                    }

                    // MARK: - Courses Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Courses")
                            .font(.title2.bold())
                            .foregroundStyle(.amberGlow)
                            .padding(.top, 8)

                        VStack(spacing: 12) {
                            CourseRowView(
                                title: "Appetisers",
                                value: $appetisers
                            )
                            CourseRowView(
                                title: "Mains",
                                value: $mainDishes
                            )
                            CourseRowView(title: "Dessert", value: $dessert)
                            CourseRowView(
                                title: "Side Dishes",
                                value: $sideDishes
                            )
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    }

                    Spacer()

                    // MARK: - Add Event Button
                    NavigationLink {
                        EventDetailView(event: Event.sampleEvent)
                    } label: {
                        Text("Add Event")
                            .font(.headline)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(.amberGlow)
                            .clipShape(.capsule)
                            .glassEffect(.regular.interactive(), in: .capsule)
                    }
                    .padding(.bottom, 20)
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
            }
            .navigationTitle("Create new event")
            .navigationBarTitleDisplayMode(.large)
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
}


#Preview {
    CreateEventView()
}

//.sheet(isPresented: $showDatePicker) {
//    DatePickerSheet(isVisible: $showDatePicker, date: $selectedDate, time: $selectedTime)
//        .presentationDetents([.fraction(0.9), .height(550)])
//}
