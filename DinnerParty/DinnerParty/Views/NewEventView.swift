//
//  NewEvenView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

struct NewEventView: View {
    
    @State var title: String = ""
    @State var date: Date = Date()
    @State var time: Date = Date()
    @State var location: String = ""
    @State var appetizers: Int = 0
    @State var mainDishes: Int = 0
    @State var desserts: Int = 0
    @State var sideDishes: Int = 0
    
    @State var isOpen: Bool = false
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Event Title", text: $title )
                        .padding(.horizontal)
                }
                .cornerRadius(24)
                
                Section {
                    
                    Button {
                        isOpen = true
                    } label: {
                        HStack() {
                            Image(systemName: "calendar")
                            Text("Date and Time")
                            
                            Spacer()
                            
                            Text("Binding of the date")
                            
                        }
                    }
                }
                
                .cornerRadius(24)
                
                Section {
                    TextField("Event Location", text: $location )
                        .padding(.horizontal)
                }
                .cornerRadius(24)
                
                Section("Courses") {
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
                .cornerRadius(24)
                
            }
            .navigationTitle("Create an event")
            .sheet(isPresented: $isOpen, content: {DateView(isPresented: $isOpen)
                .presentationDetents([.fraction(0.9), .height(550)])}
            )
            
        }
    }
}

#Preview {
    NewEventView()
}
