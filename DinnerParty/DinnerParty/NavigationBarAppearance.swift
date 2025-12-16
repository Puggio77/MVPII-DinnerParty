//
//  NavigationBarAppearance.swift
//  DinnerParty
//
//  Created for app-wide navigation bar styling
//

import UIKit

enum NavigationBarAppearance {
    /// Configures the navigation bar appearance with bold serif fonts for the entire app.
    /// Call this once at app launch (e.g., in the App struct's init).
    static func configure() {
        // Get preferred fonts for different text styles
        let largeTitle = UIFont.preferredFont(forTextStyle: .largeTitle)
        let regularTitle = UIFont.preferredFont(forTextStyle: .body)
        
        // Define descriptor with serif design and bold weight for large title
        let serifDescriptor = largeTitle.fontDescriptor.withDesign(.serif)!
        let boldSerifDescriptor = serifDescriptor.withSymbolicTraits(.traitBold)!
        let largeFont = UIFont(descriptor: boldSerifDescriptor, size: largeTitle.pointSize)
        
        // Define descriptor with serif design and bold weight for inline title
        let regularSerifDescriptor = regularTitle.fontDescriptor.withDesign(.serif)!
        let regularBoldDescriptor = regularSerifDescriptor.withSymbolicTraits(.traitBold)!
        let regularFont = UIFont(descriptor: regularBoldDescriptor, size: regularTitle.pointSize)
        
        // Apply to navigation bar appearance globally
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: largeFont]
        UINavigationBar.appearance().titleTextAttributes = [.font: regularFont]
    }
}

