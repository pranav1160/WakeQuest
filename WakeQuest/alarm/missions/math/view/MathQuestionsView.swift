//
//  MathQuestionView.swift
//  WakeQuest
//
//  Created by Pranav on 04/08/25.
//

import SwiftUI


struct MathQuestionsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: MathViewModel
    let questionText = MathQuestion.samples[3].text
    @State private var ans = ""
    @FocusState private var showKeyPad
    
    var body: some View {
        VStack(spacing:50){
            
            ProgressView(value: viewModel.timerProgress)
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .padding(.horizontal)
                .animation(.linear(duration: 1.0), value: viewModel.timerProgress)
            
            Text("\(viewModel.currentQuestion.text) = ? ")
                .font(.system(size: 40))
                .bold()
                
            Text("\(viewModel.answerRemark)")
                .font(.title)
                .frame(width: 200,height: 50)
                .padding(.bottom)
            
            TextField("", text: $ans)
                .padding()
                .font(.largeTitle)
                .bold()
                .frame(width: 250, height: 90)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 1)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .focused($showKeyPad)
                .keyboardType(.decimalPad)
            
            Button("Submit") {
                if let intAnswer = Int(ans) {
                    viewModel.submitAnswer(intAnswer)
                    ans = ""
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .onChange(of: viewModel.shouldDismiss, { oldValue, newValue in
            dismiss()
        })
        
        .onAppear{
            viewModel.startTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showKeyPad = true
            }
            
            
        }
        .fullScreenCover(isPresented: $viewModel.showAlarmView) {
            AlarmView() 
        }
    }
}

#Preview {
    MathQuestionsView(
        viewModel: MathViewModel(totalQuestion: 5, difficulty: .easy)
    )
}
