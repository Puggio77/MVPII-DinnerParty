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
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(Color.orange, lineWidth: 6)
                )
            
            Text(text)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color(red: 0.5, green: 0, blue: 0))
                .multilineTextAlignment(.center)
                .padding(32)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(3/4, contentMode: .fit)
    }
}
