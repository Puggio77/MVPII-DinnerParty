//
//  DrawChallengeView.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import SwiftUI
import Combine

struct DrawChallengeView: View {
    
    let eventID: UUID
    let courseType: String
    
    @ObservedObject private var viewModel = CardChallengeViewModel.shared
    @ObservedObject private var eventManager = EventManager.shared
    
    @State private var isShuffling = true
    @State private var showChallenge = false
    @State private var userName: String = "You" // TODO: Get from user profile/CloudKit
    
    @Environment(\.dismiss) var dismiss
    
    private var event: Event? {
        eventManager.getEvent(by: eventID)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                
                ZStack {
                    if let challenge = viewModel.currentCard, showChallenge {
                        ChallengeCardView(text: challenge.challenge)
                            .transition(.asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .opacity
                            ))
                    } else {
                        ChallengeCardView(text: "")
                            .opacity(0)
                    }
                }
                .frame(maxHeight: .infinity)
                
                if showChallenge {
                    Button {
                        dismiss()
                    } label: {
                        Text("Confirm Challenge")
                            .font(.headline)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                } else {
                    Button {
                        drawChallenge()
                    } label: {
                        Text("Draw your Challenge")
                            .font(.headline)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(isShuffling ? Color.orange : Color.gray.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                    .disabled(!isShuffling)
                }
                
                ShufflingDeckView(isShuffling: isShuffling)
                    .frame(height: 260)
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            isShuffling = true
            showChallenge = false
            viewModel.currentCard = nil
        }
        .navigationTitle("Draw for \(courseType)")
    }
    
    private func drawChallenge() {
        guard var event = event else { return }
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            _ = viewModel.drawAndClaimChallenge(
                for: &event,
                courseType: courseType,
                claimedBy: userName
            )
            
            // Save the updated event
            eventManager.updateEvent(event)
            
            showChallenge = true
            isShuffling = false
        }
    }
}

#Preview {
    DrawChallengeView(eventID: Event.sampleEvent.id, courseType: "Main Dishes")
}
