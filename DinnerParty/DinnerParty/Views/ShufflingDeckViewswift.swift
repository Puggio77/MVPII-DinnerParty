//
//  ShufflingDeckViewswift.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 10/12/25.
//

import SwiftUI

struct ShufflingDeckView: View {
    let isShuffling: Bool
    
    @State private var animate = false
    
    // Fan layout configuration
    private let cardCount = 4
    private let fanSpreadAngle: Double = 12 // degrees between each card
    private let cardWidth: CGFloat = 120
    private let cardHeight: CGFloat = 160
    
    var body: some View {
        ZStack {
            ForEach(0..<cardCount, id: \.self) { index in
                let rotation = fanRotation(for: index)
                let offset = fanOffset(for: index)
                
                BackCardView()
                    .frame(width: cardWidth, height: cardHeight)
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    .rotationEffect(.degrees(rotation), anchor: .bottom)
                    .offset(x: offset, y: isShuffling && animate ? -8 : 0)
                    .opacity(isShuffling ? 1 : 0.3)
                    .animation(
                        isShuffling
                            ? .easeInOut(duration: 0.5)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.08)
                            : .easeOut(duration: 0.3),
                        value: animate
                    )
                    .animation(.easeOut(duration: 0.3), value: isShuffling)
            }
        }
        .onAppear {
            if isShuffling {
                startAnimation()
            }
        }
        .onChange(of: isShuffling) { _, newValue in
            if newValue {
                startAnimation()
            } else {
                animate = false
            }
        }
    }
    
    /// Calculate rotation for fan effect - cards spread from center
    private func fanRotation(for index: Int) -> Double {
        // Center the fan: for 4 cards, rotations are -18, -6, 6, 18
        let centerOffset = Double(cardCount - 1) / 2.0
        return (Double(index) - centerOffset) * fanSpreadAngle
    }
    
    /// Calculate horizontal offset for fan effect
    private func fanOffset(for index: Int) -> CGFloat {
        let centerOffset = CGFloat(cardCount - 1) / 2.0
        return (CGFloat(index) - centerOffset) * 25
    }
    
    private func startAnimation() {
        animate = true
    }
}
