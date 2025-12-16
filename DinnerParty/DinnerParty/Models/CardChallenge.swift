//
//  CardChallenge.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import Foundation

struct CardChallenge: Identifiable, Codable {
    let id: UUID
    var challenge: String
    var img: String
    
    init(id: UUID = UUID(), challenge: String, img: String = "person.fill") {
        self.id = id
        self.challenge = challenge
        self.img = img
    }
}
