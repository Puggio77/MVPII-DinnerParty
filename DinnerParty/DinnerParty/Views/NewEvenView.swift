//
//  NewEvenView.swift
//  DinnerParty
//
//  Created by Aleksandra Stupiec on 05/12/25.
//

import SwiftUI

struct NewEvenView: View {
    
    @State var eventName: String = ""
    @State var name: String = ""
    
    @State private var date = Date.now
    
    
    var body: some View {
        VStack{
            GroupBox {
                TextField("Enter Event Name", text: $eventName )
                    .padding(.horizontal)
                
                
            }
            .padding()
            .cornerRadius(24)
        }
    }
}

#Preview {
    NewEvenView()
}
