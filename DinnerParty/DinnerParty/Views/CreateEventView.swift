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
    
    @State private var appetisers = 0
    @State private var mainDishes = 0
    @State private var dessert = 0
    @State private var sideDishes = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                // MARK: - Event Title Input
                TextField("", text: $eventTitle,
                          prompt: Text("Event Title").foregroundColor(.gray)
                )
                .font(.system(size: 17))
                .padding()
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(25)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .shadow(color: .gray.opacity(0.25), radius: 5, y: 3)
                
                // MARK: - Location Input
                TextField("", text: $eventLocation,
                          prompt: Text("Event Location").foregroundColor(.gray)
                )
                .font(.system(size: 17))
                .padding()
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(25)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .shadow(color: .gray.opacity(0.25), radius: 5, y: 3)
                
                // MARK: - Date Button
                Button {
                    showDatePicker.toggle()
                } label: {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Date and Time")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AmberGlow"))
                    .cornerRadius(30)
                }
                .padding(.horizontal, 40)
                
                // MARK: - Courses
                VStack(alignment: .leading, spacing: 12) {
                    Text("Courses")
                        .font(.system(size: 22, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 12) {
                        CourseCounter(title: "Appetizers", count: $appetisers)
                        CourseCounter(title: "Main Dishes", count: $mainDishes)
                        CourseCounter(title: "Desserts", count: $dessert)
                        CourseCounter(title: "Side Dishes", count: $sideDishes)
                    }
                }
                .padding(.horizontal, 30)
                
                // MARK: - Add Event Button
                Button {
                    createAndNavigateToEvent()
                } label: {
                    Text("Add Event")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(eventTitle.isEmpty ? Color.gray : Color("AmberGlow"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 40)
                .disabled(eventTitle.isEmpty)
                
                Spacer()
            }
            
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(selectedDate: $selectedDate, isVisible: $showDatePicker)
            }
            .navigationTitle("Create an Event")
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
