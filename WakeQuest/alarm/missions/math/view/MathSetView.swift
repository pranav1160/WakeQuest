//
//  MathSetView.swift
//  WakeQuest
//
//  Created by Pranav on 04/08/25.
//

import SwiftUI

struct MathSetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedIndex:Int = 0
    @State private var questionCount = 2
    @State private var showQuestionView = false

    
    var selectedDifficulty:Difficulty{
        Difficulty(rawValue: Int(selectedIndex)) ?? .veryEasy
    }
    
    var selectedQuestion:MathQuestion{
        MathQuestion.samples[selectedDifficulty.rawValue]
    }
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                //example
                    
                    Text("Sample: \(selectedQuestion.text) = ?")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300,height: 50)
                        .background(Color.theme.MediumBlue.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom,50)
                    
                    
                    Text("\(selectedDifficulty.label)")
                        .font(.title2)
                        .bold()
                }
                
                VStack{
                //slider
                    Slider(value: Binding(
                        get: { Double(selectedIndex) },
                        set: { selectedIndex = Int($0) }
                    ), in: 0...4, step: 1)
                        .padding(.horizontal)
                }
                
                VStack{
                    //rotator
                    Text("Number of Questions")
                        .font(.title2)
                    Picker("Number of Questions", selection: $questionCount) {
                        ForEach(1...8, id: \.self) { count in
                            Text("\(count)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    .clipped()
                    
                }
                
                VStack{
                    //buttons
                    Button{
                        //INITIATE THE ALARM
                        showQuestionView = true
                    }label: {
                        Text("Set")
                            .padding()
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.theme.MyPink)
                            .clipShape(.capsule)
                    }
                }
            }
            .toolbar{
                ToolbarItem (placement:.topBarLeading){
                    Button{
                        dismiss()
                    }label:{
                        Image(systemName: "chevron.left")
                    }
                }
                
             
                
            }
            .navigationTitle("Math")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showQuestionView) {
                MathQuestionsView(
                    viewModel: MathViewModel(
                        totalQuestion: questionCount,
                        difficulty: selectedDifficulty
                    )
                )
            }

        }
      
    }
}

#Preview {
    MathSetView()
       
}
