//
//  DinnerPartyApp.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 03/12/25.
//

import SwiftUI

@main
struct DinnerPartyApp: App {
    
    init() {
        // Configure navigation bar appearance with bold serif font for the entire app
        NavigationBarAppearance.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EventsMainView()
        }
    }
}
