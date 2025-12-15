//
//  CountdownTimerView.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 14/12/25.
//

import SwiftUI
import Combine

struct CountdownTimerView: View {
    let eventDate: Date
    
    @State private var timeRemaining: TimeComponents = TimeComponents()
    
    // Timer publisher that fires every second
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 15) {
            TimeUnitView(value: timeRemaining.days, unit: "Days", showColon: true)
            Text(":")
                .font(.system(size: 34, weight: .semibold))
                .offset(y: -15)
            TimeUnitView(value: timeRemaining.hours, unit: "Hours", showColon: false)
            Text(":")
                .font(.system(size: 34, weight: .semibold))
                .offset(y: -15)
            TimeUnitView(value: timeRemaining.minutes, unit: "Minutes", showColon: true)
        }
        .onAppear {
            updateTimeRemaining()
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }
    
    private func updateTimeRemaining() {
        timeRemaining = calculateTimeRemaining(until: eventDate)
    }
    
    private func calculateTimeRemaining(until date: Date) -> TimeComponents {
        let now = Date()
        let difference = date.timeIntervalSince(now)
        
        // return zeros if the event has passed
        guard difference > 0 else {
            return TimeComponents(days: 0, hours: 0, minutes: 0)
        }
        
        let totalSeconds = Int(difference)
        
        let days = totalSeconds / 86400  // 60 * 60 * 24
        let remainingAfterDays = totalSeconds % 86400
        
        let hours = remainingAfterDays / 3600  // 60 * 60
        let remainingAfterHours = remainingAfterDays % 3600
        
        let minutes = remainingAfterHours / 60
        
        return TimeComponents(days: days, hours: hours, minutes: minutes)
    }
}

// MARK: Individual Time Unit Display
struct TimeUnitView: View {
    let value: Int
    let unit: String
    let showColon: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                Text(String(format: "%02d", value))
                    .font(.system(size: 34, weight: .semibold))
                
            }
            
            Text(unit)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 40) {
        // Future event
        CountdownTimerView(
            eventDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date()
        )
        
        // Past event
        CountdownTimerView(
            eventDate: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        )
    }
    .padding()
}
