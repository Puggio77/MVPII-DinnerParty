//
//  ChallengeCardsScrollView.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 16/12/25.
//

import SwiftUI

struct ChallengeCardsScrollView: View {
    let eventID: UUID
    let courseType: String
    
    @ObservedObject private var eventManager = EventManager.shared
    
    private var event: Event? {
        eventManager.getEvent(by: eventID)
    }
    
    var body: some View {
        if let event = event {
            let courseCount = event.courseCount(for: courseType)
            let claimedForCourse = event.claimedChallenges[courseType] ?? []
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<courseCount, id: \.self) { index in
                        if index < claimedForCourse.count {
                            ClaimedChallengeCardView(claimed: claimedForCourse[index])
                        } else {
                            UnclaimedChallengeCardView(
                                eventID: eventID,
                                courseType: courseType
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 300)
        }
    }
}

struct ClaimedChallengeCardView: View {
    let claimed: ClaimedChallenge
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.yellow, lineWidth: 3)
                )
            
            VStack(spacing: 16) {
                Text(claimed.challengeText)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color(.systemBrown))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("Claimed by")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(claimed.claimedBy)
                        .font(.headline)
                }
            }
            .padding(.vertical, 28)
        }
        .frame(width: 250, height: 280)
    }
}

struct UnclaimedChallengeCardView: View {
    let eventID: UUID
    let courseType: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)
            
            VStack(spacing: 20) {
                Text("Draw a card to\nreveal")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color(.systemBrown))
                    .multilineTextAlignment(.center)
                
                NavigationLink {
                    DrawChallengeView(eventID: eventID, courseType: courseType)
                } label: {
                    Text("Claim")
                        .font(.headline)
                        .frame(width: 180)
                        .padding(.vertical, 14)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(26)
                        .shadow(color: Color.orange.opacity(0.25), radius: 10, x: 0, y: 6)
                }
            }
            .padding(.vertical, 28)
        }
        .frame(width: 250, height: 280)
    }
}
