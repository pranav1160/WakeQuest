//
//  GameViewModel.swift
//  WakeQuest
//
//  Created by Pranav on 08/08/25.
//


// File: ViewModels/GameViewModel.swift
import Foundation
import Combine

final class GameViewModel: ObservableObject {
    // Input
    @Published private(set) var cards: [Card] = []
    @Published private(set) var timeRemaining: TimeInterval
    @Published var isGameOver: Bool = false
    @Published private(set) var score: Int = 0

    private var settings: GameSettings
    private var cancellables = Set<AnyCancellable>()

    // Timer
    private var timer: AnyCancellable?
    
    var timeLimit: TimeInterval {
        settings.timeLimit
    }


    // Game state
    private var indexOfOnlyFaceUpCard: Int? = nil

    init(settings: GameSettings = GameSettings()) {
        self.settings = settings
        self.timeRemaining = settings.timeLimit
        resetGame()
    }

    func resetGame() {
        cards = DeckGenerator.makeDeck(pairs: settings.numberOfPairs)
        timeRemaining = settings.timeLimit
        score = 0
        isGameOver = false
        indexOfOnlyFaceUpCard = nil
        stopTimer()
        startTimer()
    }

    // MARK: - Timer
    private func startTimer() {
        stopTimer()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tick()
            }
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    private func tick() {
        guard !isGameOver else { return }
        timeRemaining -= 1
        if timeRemaining <= 0 {
            timeRemaining = 0
            gameOver()
        }
    }

    private func gameOver() {
        isGameOver = true
        stopTimer()
    }

    // MARK: - Game Logic
    func flipCard(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched, !isGameOver else { return }

        // Flip chosen card
        cards[chosenIndex].isFaceUp = true

        if let potentialIndex = indexOfOnlyFaceUpCard {
            // There is one card already face up — check for match
            if cards[potentialIndex].content == cards[chosenIndex].content {
                // It's a match!
                cards[potentialIndex].isMatched = true
                cards[chosenIndex].isMatched = true
                score += 10
                // Clear index
                indexOfOnlyFaceUpCard = nil
                checkWinCondition()
            } else {
                // Not a match — apply penalty and flip back after delay
                timeRemaining = max(0, timeRemaining - settings.flipPenalty)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
                    guard let self = self else { return }
                    self.cards[potentialIndex].isFaceUp = false
                    self.cards[chosenIndex].isFaceUp = false
                    self.indexOfOnlyFaceUpCard = nil
                }
            }
        } else {
            // No other card face up — mark this one
            for i in cards.indices {
                if cards[i].isFaceUp && !cards[i].isMatched {
                    // leave as-is
                }
            }
            indexOfOnlyFaceUpCard = chosenIndex
        }
    }

    private func checkWinCondition() {
        if cards.allSatisfy({ $0.isMatched }) {
            // player won — give bonus for time left
            score += Int(timeRemaining)
            gameOver()
        }
    }
}
