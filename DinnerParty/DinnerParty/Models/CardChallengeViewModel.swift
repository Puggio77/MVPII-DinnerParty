//
//  CardChallengeViewModel.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import Foundation
import SwiftUI
import Combine

class CardChallengeViewModel: ObservableObject {
    
    static let allChallenges: [CardChallenge] = ChallengeData.allChallenges
    
    @Published var currentCard: CardChallenge?
    
    static let shared = CardChallengeViewModel()
    
    private init() {}
    
    // Draw a challenge and claim it for a specific course
    func drawAndClaimChallenge(
        for event: inout Event,
        courseType: String,
        claimedBy: String
    ) -> CardChallenge? {
        
        // Get already used challenge IDs for this event (all courses)
        let allClaimedIDs = event.claimedChallenges.values
            .flatMap { $0 }
            .map { $0.challengeID }
        
        // Filter to available challenges
        let availableChallenges = CardChallengeViewModel.allChallenges.filter {
            !allClaimedIDs.contains($0.id)
        }
        
        guard let selectedChallenge = availableChallenges.randomElement() else {
            return nil // All challenges used
        }
        
        // Create the claimed challenge
        let claimed = ClaimedChallenge(
            challengeID: selectedChallenge.id,
            challengeText: selectedChallenge.challenge,
            claimedBy: claimedBy
        )
        
        // Add to the event's claimed challenges for this course
        var courseChallenges = event.claimedChallenges[courseType] ?? []
        courseChallenges.append(claimed)
        event.claimedChallenges[courseType] = courseChallenges
        
        currentCard = selectedChallenge
        return selectedChallenge
    }
}
