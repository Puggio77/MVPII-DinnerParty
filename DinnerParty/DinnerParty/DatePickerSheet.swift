
//
//  DatePickerSheet.swift
//  LuckyPot_1
//
//  Created by Seyedreza Aghayarikordkandi on 09/12/25.
//

import SwiftUI

struct DatePickerSheet: View {

    @Binding var isVisible: Bool

    @Binding var date: Date
    
    var body: some View {
        VStack(spacing: 20) {

            // --- TOP HANDLER ---
//            Capsule()
//                .fill(Color.gray.opacity(0.3))
//                .frame(width: 40, height: 5)
//                .padding(.top, 16)

            HStack {
                //  dismiss button
                Button(action: { isVisible = false }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                }
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)

                Spacer()

                Text("Pick a Date and Time")
                    .font(.system(size: 22))

                Spacer()

                //  confirm
                Button(action: { isVisible = false }) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                }
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
            }
            .padding()

            // --- DATE PICKER ---
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        
            Divider()
            .padding(.horizontal)
        
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.hourAndMinute]
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal)
            
        }
        .frame(height: 550)
    }
}

#Preview {
    DatePickerSheet(isVisible: .constant(true), date: .constant(Date()))
}
