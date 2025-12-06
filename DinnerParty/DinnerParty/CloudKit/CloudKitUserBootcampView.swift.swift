//
//  CloudKitUserBootcampView.swift.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 05/12/25.
//

import SwiftUI

struct CloudKitUserBootcamp: View {

    @StateObject private var vm = CloudKitUserBootCampViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Text("Is signed in: \(vm.isSignedToiCloud.description.uppercased())")
            Text("Name: \(vm.userName)")
            if !vm.error.isEmpty {
                Text("Error: \(vm.error)")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    CloudKitUserBootcamp()
}
