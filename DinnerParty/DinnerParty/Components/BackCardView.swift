//
//  BackCardView.swift
//  DinnerParty
//
//  Created by Son Cao on 16/12/25.
//

import SwiftUI

struct BackCardView: View {
    var body: some View {
        Image(.cardPattern)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .aspectRatio(3/4, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.warmCream, lineWidth: 5)
            )
    }
}

#Preview {
    BackCardView()
        .padding(50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
}
