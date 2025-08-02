//
//  QuestionMainView.swift
//  WakeQuest
//
//  Created by Pranav on 02/08/25.
//

import SwiftUI

struct QuestionMainView: View {
    
    @StateObject var quesVM = QuestionViewModel()
    @State private var selectedOption: Int? = nil
    @State private var showNext = false
   
    var body: some View {
        VStack(spacing: 30) {
            Text(quesVM.questionText)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.purple)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)
                )
                .padding(.horizontal)
            
            // Options
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(quesVM.options, id: \.self) { option in
                    OptionButton(
                        thisOption: option,
                        isSelected: selectedOption == option,
                        isCorrect: option == quesVM.currentAnswer,
                        isAnswered: selectedOption != nil
                    ) {
                        if selectedOption == nil {
                            selectedOption = option
                            quesVM.checkAnswer(option)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                showNext = true
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            // Answer Feedback
            if let message = quesVM.message {
                Text(message)
                    .font(.title.bold())
                    .foregroundColor(message.contains("Correct") ? .green : .red)
                    .transition(.opacity)
            }
            
            // Next Button
            if showNext {
                Button("Next Question") {
                    quesVM.generateQuestion()
                    selectedOption = nil
                    showNext = false
                }
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding()
                .background(Color.orange)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.top, 10)
            }
            
            Spacer()
            
            
            
        }
        .padding(.bottom)
        .background(Color.black)
        .animation(.easeInOut, value: selectedOption)
    }
}

#Preview {
    QuestionMainView()
}

let lightColors: [Color] = [
    Color(red: 255/255, green: 204/255, blue: 204/255), // light pink
    Color(red: 204/255, green: 255/255, blue: 229/255), // light aqua
    Color(red: 204/255, green: 229/255, blue: 255/255), // light sky blue
    Color(red: 255/255, green: 255/255, blue: 204/255), // light lemon
    Color(red: 229/255, green: 204/255, blue: 255/255), // light lavender
    Color(red: 255/255, green: 229/255, blue: 204/255)  // light apricot
]


struct OptionButton: View {
    @State private var isPopped = false
    @State private var hideBalloon = false
    
    let thisOption: Int
    let isSelected: Bool
    let isCorrect: Bool
    let isAnswered: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
            withAnimation {
                isPopped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    hideBalloon = true
                }
            }
        }) {
            BalloonView(
                option: thisOption,
                startOffset: 0,
                endOffset: 300,
                color1: lightColors.randomElement()!,
                color2: lightColors.randomElement()!
            )
        }
        .disabled(isAnswered)
        .animation(.spring(), value: isSelected)
    }
}


