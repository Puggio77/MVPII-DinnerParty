//
//  CourseCounter.swift
//  LuckyPot_1
//
//  Created by Seyedreza Aghayarikordkandi on 09/12/25.
//

import Foundation
import SwiftUI

struct CourseCounter: View {
    let title: String
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
            
            Spacer()
            
            Text("\(count)")
                .font(.system(size: 17, weight: .medium))
            
            HStack(spacing: 12) {
                
                // MINUS BUTTON
                Button(action: {
                    if count > 0 {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            count -= 1
                        }
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(count == 0 ? .gray.opacity(0.3) : .black)
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 32, height: 32)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(Circle())
                }
                
                // PLUS BUTTON
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        count += 1
                    }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)   // ← رنگ مشکی اضافه شد
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 32, height: 32)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    CourseCounter(title: "Appetisers", count: .constant(2))
}

