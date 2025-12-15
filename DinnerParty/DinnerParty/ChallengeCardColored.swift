//
//  ChallengeCardColored.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 12/12/25.
//

import SwiftUI

struct ChallengeCardColored: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(Color("AmberGlow"), lineWidth: 6)
                )
            
            Text(text)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color("DarkAmaranth"))
                .multilineTextAlignment(.center)
                .padding(32)
        }
        .frame(width: 260, height: 350)
    }
}

#Preview {
    ChallengeCardColored(text: "Use an ingredient that starts with S")
}
