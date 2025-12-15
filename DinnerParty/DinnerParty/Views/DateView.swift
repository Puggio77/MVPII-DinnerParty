//
//  DateView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 09/12/25.
//

import SwiftUI

struct DateView: View {
    
    @State private var eventDate = Date()
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 50) {
                    Button() {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.circle)
                    .padding(.horizontal)

                    Text("Pick Date and Time")
                    
                    Button() {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.circle)
                    .padding(.horizontal)

                }
                DatePicker(
                    "Start Date",
                    selection: $eventDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            
                Divider()
                .padding(.horizontal)
            
                DatePicker(
                    "Start Date",
                    selection: $eventDate,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.graphical)
                .padding(.horizontal)
            
        }
        .frame(height: 550)
    }
}


#Preview {
    DateView(isPresented: .constant(true))
}
