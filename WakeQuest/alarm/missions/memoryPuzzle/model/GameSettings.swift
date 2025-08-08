//
//  GameSettings.swift
//  WakeQuest
//
//  Created by Pranav on 08/08/25.
//



// File: Models/GameSettings.swift
import Foundation

struct GameSettings {
    var numberOfPairs: Int = 8
    var timeLimit: TimeInterval = 120 // seconds
    var flipPenalty: TimeInterval = 2 // seconds lost for wrong match
}

// File: Services/DeckGenerator.swift
import Foundation

struct DeckGenerator {
    static func makeDeck(pairs: Int) -> [Card] {
        // simple emoji deck
        let pool = ["🐶","🐱","🦊","🐼","🐨","🐵","🦁","🐯","🐸","🐙","🦄","🐷","🐮","🐔","🐧","🐢"]
        let chosen = Array(pool.prefix(pairs))
        var cards: [Card] = []
        for emoji in chosen {
            cards.append(Card(content: emoji))
            cards.append(Card(content: emoji))
        }
        cards.shuffle()
        return cards
    }
}
