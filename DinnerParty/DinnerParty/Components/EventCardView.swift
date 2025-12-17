//
//  EventCardView.swift
//  DinnerParty
//
//  Created on 15/12/25.
//

import SwiftUI

struct EventCardView: View {
    let event: Event
    var isUpcoming: Bool = true
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: event.date)
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: event.time)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(event.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            
            Text("\(formattedDate) · \(formattedTime)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isUpcoming ? Color.amberGlow : Color.gray.opacity(0.2), lineWidth: isUpcoming ? 2 : 1)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        EventCardView(event: Event.sampleEvent, isUpcoming: true)
        EventCardView(event: Event.sampleEvent, isUpcoming: false)
    }
    .padding()
}
