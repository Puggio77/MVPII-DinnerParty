//
//  DatePickerSheet.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 12/16/25.
//

import SwiftUI

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Binding var isVisible: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button {
                        isVisible = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Text("Pick Date and Time")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        isVisible = false
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.amberGlow)
                    }
                }
                .padding()
                
                // Date Picker
                DatePicker(
                    "Select Date and Time",
                    selection: $selectedDate,
                    in: Date.now...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    DatePickerSheet(
        selectedDate: .constant(Date()),
        isVisible: .constant(true)
    )
}
