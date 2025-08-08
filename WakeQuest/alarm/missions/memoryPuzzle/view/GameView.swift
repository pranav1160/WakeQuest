//
//  GameView.swift
//  WakeQuest
//
//  Created by Pranav on 08/08/25.
//


// File: Views/GameView.swift
import SwiftUI

struct GameView: View {
    @StateObject private var vm = GameViewModel()

    // grid layout
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Score: \(vm.score)")
                            .font(.headline)
                        Text(vm.isGameOver ? "Game Over" : "Playing")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: { vm.resetGame() }) {
                        Text("Restart")
                    }
                }
                .padding()

                TimerView(timeRemaining: vm.timeRemaining, total: vm.timeLimit)
                    .padding(.bottom)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(vm.cards) { card in
                            CardView(card: card, width: cardWidth, height: cardHeight) { tapped in
                                vm.flipCard(tapped)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationTitle("TimeMatch")
            .alert(isPresented: $vm.isGameOver) {
                Alert(title: Text("Game Over"), message: Text("Your score: \(vm.score)"), dismissButton: .default(Text("Play Again"), action: { vm.resetGame() }))
            }
        }
    }

    private var cardWidth: CGFloat {
        (UIScreen.main.bounds.width - 60) / 4
    }

    private var cardHeight: CGFloat { cardWidth * 1.2 }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
