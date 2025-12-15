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
                        HStack{
                            Text("Apetisers")
                            CourseStepperView()
                        }
                        HStack{
                            Text("Main Dishes")
                            CourseStepperView()
                        }
                        HStack{
                            Text("Desserts")
                            CourseStepperView()
                        }
                        HStack{
                            Text("Side Dishes")
                            CourseStepperView()
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                NavigationLink{
                    EventDetailView(event: Event.sampleEvent)
                } label: {
                    Text("Add Event")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AmberGlow"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(isVisible: $showDatePicker, date: $selectedDate, time: $selectedTime)
                    .presentationDetents([.fraction(0.9), .height(550)])
            }
            .navigationTitle("Create an Event")
            .padding(.top)
        }
    }
    
}

#Preview {
    CreateEventView()
    
}
