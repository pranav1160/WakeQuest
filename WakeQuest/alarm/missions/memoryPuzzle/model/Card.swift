//
//  Card 2.swift
//  WakeQuest
//
//  Created by Pranav on 08/08/25.
//


// TimeMatchGame - SwiftUI MVVM
// Project skeleton: time-based card flipping & matching game

// File: Models/Card.swift
import Foundation
import SwiftUI

struct Card: Identifiable, Equatable {
    let id: UUID
    let content: String // could be emoji or image name
    var isFaceUp: Bool = false
    var isMatched: Bool = false

    init(id: UUID = UUID(), content: String) {
        self.id = id
        self.content = content
    }
}
