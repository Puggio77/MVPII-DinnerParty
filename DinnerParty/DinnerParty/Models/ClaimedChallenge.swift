//
//  ClaimedChallenge.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 16/12/25.
//

import Foundation

struct ClaimedChallenge: Identifiable, Codable {
    let id: UUID
    let challengeID: UUID
    let challengeText: String
    let claimedBy: String
    let claimedAt: Date
    
    init(
        id: UUID = UUID(),
        challengeID: UUID,
        challengeText: String,
        claimedBy: String,
        claimedAt: Date = Date()
    ) {
        self.id = id
        self.challengeID = challengeID
        self.challengeText = challengeText
        self.claimedBy = claimedBy
        self.claimedAt = claimedAt
    }
}
