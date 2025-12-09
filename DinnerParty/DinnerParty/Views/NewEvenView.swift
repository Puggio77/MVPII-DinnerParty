//
//  NewEvenView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

struct NewEvenView: View {
    
    @State var eventName: String = ""
    @State var name: String = ""
        
    @State var apetisers: Int = 0
    @State var mainDishes: Int = 0
    @State var desserts: Int = 0
    @State var sideDishes: Int = 0
    
    @State var isOpen: Bool = false
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Event Title", text: $eventName )
                        .padding(.horizontal)
                }
                .cornerRadius(24)
                
                Section {
                    
                    Button {
                        isOpen = true
                    } label: {
                        HStack(alignment: .center) {
                            Image(systemName: "calendar")
                            Text("Date and Time")
                            
                        }
                    }
                }
                
                .cornerRadius(24)
                
                Section {
                    TextField("Event Location", text: $eventName )
                        .padding(.horizontal)
                }
                .cornerRadius(24)
                
                Section("Courses") {
                    HStack{
                        Text("Apetisers")
                        Button("+") {
                            apetisers = 0
                        }
                    }
                    
                    HStack{
                        Text("Main Dishes")
                        Button("+") {
                            apetisers = 0
                        }
                    }
                    
                    HStack{
                        Text("Desserts")
                        Button("+") {
                            apetisers = 0
                        }
                    }
                    
                    HStack{
                        Text("Side Dishes")
                        Button("+") {
                            apetisers = 0
                        }
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
    NewEvenView()
}
