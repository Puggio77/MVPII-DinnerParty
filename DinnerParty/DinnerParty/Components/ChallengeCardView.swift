//
//  ChallengeCardView.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 10/12/25.
//

import SwiftUI

struct ChallengeCardView: View {
    let text: String
    
    var body: some View {
        ZStack {
            // Orange background card
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.vibrantOrange)
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(Color.white, lineWidth: 5)
                )
            
            // "Challenge" label at top-left
            VStack {
                HStack {
                    Text("Challenge")
                        .font(.system(.title3, design: .serif))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.warmCream)
                        .padding(.leading, 24)
                        .padding(.top, 24)
                    Spacer()
                }
                Spacer()
            }
            
            // Center oval with challenge text
            Ellipse()
                .fill(Color.warmCream)
                .padding(.horizontal, 30)
                .padding(.vertical, 50)
                .rotationEffect(.degrees(23))
            
            Text(text)
                .font(.system(.title2, design: .serif))
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)
            
            // 4-pointed star in bottom-right corner
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(.cardDiamondSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .padding(3)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(3/4, contentMode: .fit)
        .rotationEffect(.degrees(4))
    }
}

// Custom 4-pointed star shape
struct FourPointedStar: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.25
        
        var path = Path()
        
        for i in 0..<8 {
            let angle = (CGFloat(i) * .pi / 4) - .pi / 2
            let radius = i.isMultiple(of: 2) ? outerRadius : innerRadius
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    ChallengeCardView(text: "Use an ingredient that starts with 'S'")
        .padding(50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        
}
