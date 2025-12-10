//
//  CardChallenge.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import Foundation

struct CardChallenge: Identifiable {
    let id = UUID()
    var challenge: String
    var img: String = "person.fill"
}

