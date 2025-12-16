//
//  ChallengeData.swift
//  DinnerParty
//
//  Created by Ana Karina Aramoni Ruiz on 16/12/25.
//

import Foundation

import Foundation

struct ChallengeData {
    static let allChallenges: [CardChallenge] = [
        // Ingredient constraints
        CardChallenge(challenge: "Use an ingredient that starts with the letter M"),
        CardChallenge(challenge: "Use an ingredient that grows underground"),
        CardChallenge(challenge: "Use an ingredient that is fermented"),
        CardChallenge(challenge: "Use an ingredient that is naturally sweet"),
        CardChallenge(challenge: "Use an ingredient commonly used in breakfast"),
        CardChallenge(challenge: "Use an ingredient that is typically used raw"),
        CardChallenge(challenge: "Use an ingredient that comes in a can"),
        CardChallenge(challenge: "Use an ingredient that is usually considered a garnish"),
        CardChallenge(challenge: "Use an ingredient that is white"),
        CardChallenge(challenge: "Use an ingredient associated with a specific country"),

        // Flavor profile challenges
        CardChallenge(challenge: "Make the dish primarily sour"),
        CardChallenge(challenge: "Make the dish umami-forward"),
        CardChallenge(challenge: "Make the dish smoky without using a grill"),
        CardChallenge(challenge: "Create contrast between creamy and crunchy"),
        CardChallenge(challenge: "Use bitterness intentionally"),
        CardChallenge(challenge: "Make a dish that tastes better the next day"),
        CardChallenge(challenge: "Create a sauce that ties everything together"),
        CardChallenge(challenge: "Use only one dominant flavor"),
        CardChallenge(challenge: "Turn a sweet ingredient savory"),
        CardChallenge(challenge: "Turn a savory ingredient sweet"),

        // Technique constraints
        CardChallenge(challenge: "Use only knife work—no appliances"),
        CardChallenge(challenge: "Cook everything at the same temperature"),
        CardChallenge(challenge: "Use a technique you recently learned"),
        CardChallenge(challenge: "Cook something two different ways"),
        CardChallenge(challenge: "Transform the texture of a main ingredient"),
        CardChallenge(challenge: "Use a technique from a different cuisine"),
        CardChallenge(challenge: "Cook without measuring anything"),
        CardChallenge(challenge: "Finish the dish with acid"),
        CardChallenge(challenge: "Cook something faster than you normally would"),
        CardChallenge(challenge: "Cook something slower than you normally would"),

        // Time & limitation challenges
        CardChallenge(challenge: "Complete the dish in under 20 minutes"),
        CardChallenge(challenge: "Use no more than 5 ingredients"),
        CardChallenge(challenge: "Use only ingredients already in your kitchen"),
        CardChallenge(challenge: "Make a dish using leftovers"),
        CardChallenge(challenge: "Make a dish suitable for a picnic"),
        CardChallenge(challenge: "Cook as if you’re feeding a large group"),
        CardChallenge(challenge: "Cook as if you’re cooking for one"),
        CardChallenge(challenge: "Make a dish that can be eaten with one hand"),

        // Presentation & experience
        CardChallenge(challenge: "Design the dish to be Instagram-worthy"),
        CardChallenge(challenge: "Plate the dish using only odd numbers"),
        CardChallenge(challenge: "Make the dish look minimal and modern"),
        CardChallenge(challenge: "Serve the dish family-style"),
        CardChallenge(challenge: "Create a dish meant to be shared"),
        CardChallenge(challenge: "Focus more on texture than flavor"),
        CardChallenge(challenge: "Make the dish feel luxurious"),

        // Conceptual / playful challenges
        CardChallenge(challenge: "Reinvent a classic comfort food"),
        CardChallenge(challenge: "Make a dish inspired by a city"),
        CardChallenge(challenge: "Make a dish inspired by a memory"),
        CardChallenge(challenge: "Cook something that surprises people"),
        CardChallenge(challenge: "Make a dish that breaks a food rule"),
        CardChallenge(challenge: "Make a dish that feels nostalgic but modern"),
        CardChallenge(challenge: "Create a dish you would serve at a dinner party"),
        CardChallenge(challenge: "Make a dish that tells a story")
    ]
}
