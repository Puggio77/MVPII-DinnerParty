//
//  DrawChallengeView.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import SwiftUI
import Combine

struct DrawChallengeView: View {
    
    @StateObject private var viewModel = CardChallengeViewModel()
    
    @State private var isShuffling = true
    @State private var showChallenge = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {

                    
                    // Card centrale
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
            .navigationTitle("Draw your challenge")
        }
    }
    
    private func drawChallenge() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            viewModel.drawRandomCard()
            showChallenge = true
            isShuffling = false
        }
    }
}

#Preview {
    DrawChallengeView()
}
