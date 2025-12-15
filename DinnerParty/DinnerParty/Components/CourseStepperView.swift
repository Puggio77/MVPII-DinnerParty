//
//  CourseStepperView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 09/12/25.
//

import SwiftUI

struct CourseStepperView: View {
    
    @State private var value = 0
    let step = 1
    let range = 0...5
    
    var body: some View {
        HStack{
            Stepper(
                value: $value,
                in: range,
                step: step
            ) {
                Text("\(value)")
            }
            .padding(5)
        }
    }
}

#Preview {
    CourseStepperView()
}
