//
//  CourseRowView.swift
//  DinnerParty
//
//  Created by Son Cao on 15/12/25.
//

import SwiftUI

// MARK: - Course Row View
struct CourseRowView: View {
    let title: String
    @Binding var value: Int
    let range = 0...10

    struct RowDividerView: View {
        var body: some View {
            // Divider
            Rectangle()
                .fill(Color.primary.opacity(0.15))
                .frame(width: 1, height: 20)
        }
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Spacer()

            // Capsule stepper with counter in the middle
            HStack(spacing: 0) {
                // Minus button
                Button {
                    if value > range.lowerBound {
                        value -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundStyle(
                            value > range.lowerBound ? .primary : .tertiary
                        )
                        .fontWeight(.bold)
                        .frame(width: 50, height: 36)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                RowDividerView()

                // Counter in the middle
                Text("\(value)")
                    .frame(width: 36, height: 36)

                RowDividerView()

                // Plus button
                Button {
                    if value < range.upperBound {
                        value += 1
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(
                            value < range.upperBound ? .primary : .tertiary
                        )
                        .frame(width: 50, height: 36)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .fontWeight(.bold)
            .background(in: Capsule())
            .glassEffect(.regular.interactive())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    @Previewable @State var value: Int = 0
    CourseRowView(title: "Appetiser", value: $value)
        .padding(.horizontal, 20)
}
