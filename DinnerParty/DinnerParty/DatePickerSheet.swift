
//
//  DatePickerSheet.swift
//  LuckyPot_1
//
//  Created by Seyedreza Aghayarikordkandi on 09/12/25.
//
import SwiftUI

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Binding var isVisible: Bool
    
    // Local state to hold the temporary date until confirmed
    @State private var tempDate: Date = Date()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // --- DATE PICKER ---
                    DatePicker(
                        "",
                        selection: $tempDate,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)
                    .padding(.horizontal, 10)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Pick a Date and Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isVisible = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        selectedDate = tempDate
                        isVisible = false
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                }
            }
        }
        .onAppear {
            // Initialize temp date with the current selected date
            tempDate = selectedDate
        }
        .interactiveDismissDisabled()
    }
}



#Preview {
    DatePickerSheet(selectedDate: .constant(Date()), isVisible: .constant(true))
        .presentationDetents([.large])
}
