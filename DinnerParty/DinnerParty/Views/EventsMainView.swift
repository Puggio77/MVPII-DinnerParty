//
//  EventsMainView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

struct EventsMainView: View {
    
    @State var isOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Upcoming") {
                    
                }
                .padding(.top, 20)
                
                Section("Past Events") {
                    
                }
            }
            .navigationTitle("My Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("+") {
                        NewEventView()
                    }
                }
            }
        }
    }
}

#Preview {
    EventsMainView()
}
