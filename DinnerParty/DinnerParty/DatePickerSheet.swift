
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

    var body: some View {
        VStack(spacing: 20) {

            // --- TOP HANDLER ---
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 16)

            // --- HEADER WITH X & CHECK ---
            HStack {
                // X dismiss button
                Button(action: { isVisible = false }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                }

                Spacer()

                Text("Pick a Date and Time")
                    .font(.system(size: 22, weight: .semibold, design: .serif))

                Spacer()

                // CHECKMARK – confirm
                Button(action: { isVisible = false }) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 20)

            // --- DATE PICKER ---
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.graphical)   // shows calendar like Figma
            .padding(.horizontal, 10)

            Spacer()
        }
        .padding(.bottom, 30)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.1), radius: 8, y: -2)
    }
}



#Preview {
    DatePickerSheet(selectedDate: .constant(Date()), isVisible: .constant(true))
}
