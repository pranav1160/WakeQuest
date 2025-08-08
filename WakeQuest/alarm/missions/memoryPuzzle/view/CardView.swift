//
//  CardView.swift
//  WakeQuest
//
//  Created by Pranav on 08/08/25.
//


// File: Views/CardView.swift
import SwiftUI

struct CardView: View {
    let card: Card
    let width: CGFloat
    let height: CGFloat
    let onTap: (Card) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(card.isFaceUp || card.isMatched ? Color.white : Color.accentColor)
                .frame(width: width, height: height)
                .shadow(radius: 4)

            if card.isFaceUp || card.isMatched {
                Text(card.content)
                    .font(.system(size: min(width, height) * 0.5))
            } else {
                Text("")
            }
        }
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.35), value: card.isFaceUp)
        .onTapGesture {
            onTap(card)
        }
        .opacity(card.isMatched ? 0.6 : 1.0)
    }
}