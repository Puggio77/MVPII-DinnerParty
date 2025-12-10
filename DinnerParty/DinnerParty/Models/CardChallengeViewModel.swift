//
//  CardChallengeViewModel.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import Foundation
import SwiftUI

class CardChallengeViewModel {
    var cards: [CardChallenge] = [
        CardChallenge(challenge: "Use an ingredient that starts with s"),
        CardChallenge(challenge: "Use an ingredient that is green"),
        CardChallenge(challenge: "Prepare a dish that starts with the first letter of your name"),
        CardChallenge(challenge: "Plate the dish using three distinct colors"),
        CardChallenge(challenge: "Use a spice you’ve never used before"),
        CardChallenge(challenge: "Use an ingredient that has only four letters"),
    ]
}
