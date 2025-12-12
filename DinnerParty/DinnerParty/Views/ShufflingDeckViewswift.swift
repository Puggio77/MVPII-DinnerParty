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
    
    var body: some View {
        ZStack {
            ForEach(0..<4) { index in
                CardBackView()
                    .rotationEffect(.degrees(Double(index) * 8 - 12))
                    .offset(x: CGFloat(index) * 40 - 60, y: 40)
                    .offset(x: animate ? 20 : -20)
                    .opacity(isShuffling ? 1 : 0.3)
            }
        }
        .onAppear {
            if isShuffling {
                startAnimation()
            }
        }
        .onChange(of: isShuffling) { newValue in
            if newValue {
                startAnimation()
            } else {
                animate = false
            }
        }
    }
    
    private func startAnimation() {
        withAnimation(
            .easeInOut(duration: 0.6)
                .repeatForever(autoreverses: true)
        ) {
            animate = true
        }
    }
}

struct CardBackView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 26, style: .continuous)
            .fill(Color.white)
            .shadow(radius: 4, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(Color.orange, lineWidth: 5)
            )
            .frame(width: 160, height: 220)
    }
}
