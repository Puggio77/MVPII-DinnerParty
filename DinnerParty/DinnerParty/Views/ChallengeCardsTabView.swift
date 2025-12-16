//
//  ChallengeCardsScrollView.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 16/12/25.
//

import SwiftUI

import SwiftUI

struct ChallengeCardsTabView: View {
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
            
            TabView {
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
            .tabViewStyle(.page)
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
            
            VStack(spacing: 70) {
                Text(claimed.challengeText)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color(.systemBrown))
                    .multilineTextAlignment(.center)
    
                
                VStack(spacing: 4) {
                    Text("Claimed by")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(claimed.claimedBy)
                        .font(.headline)
                }
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 30)
        }
        .frame(width: 300, height: 350)
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
            
            VStack(spacing: 70) {
                Text("Draw a card to\nreveal")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color(.systemBrown))
                    .multilineTextAlignment(.center)
                
            
                NavigationLink {
                    DrawChallengeView(eventID: eventID, courseType: courseType)
                } label: {
                    Text("Claim")
                        .font(.headline)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 100)
                        .background(.amberGlow, in: .capsule)
                        .foregroundColor(.white)
                        .glassEffect(.regular.interactive())
                }
            }
            .padding(.vertical, 50)
        }
        .frame(width: 300, height: 350)
    }
}
