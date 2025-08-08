//
//  MathQuestionGenerator.swift
//  WakeQuest
//
//  Created by Pranav on 04/08/25.
//


struct MathQuestionGenerator{
    //we can use static in a view model as long as it doesnt depend on self properties of a view model
    static func generateQuestions(count:Int,level:Difficulty)->[MathQuestion]{
        var arr:[MathQuestion] = []
        for _ in 1...count{
            arr.append(generateQuestion(difficulty: level))
        }
        return arr
    }
    
    static func generateQuestion(difficulty: Difficulty) -> MathQuestion {
        let op: Operator = .add // You can randomize later if needed
        
        switch difficulty {
        case .veryEasy:
            return MathQuestion(numbers: [Int.random(in: 1...10), Int.random(in: 1...10)], op: op)
        case .easy:
            return MathQuestion(numbers: [Int.random(in: 10...30), Int.random(in: 10...30)], op: op)
        case .normal:
            return MathQuestion(numbers: [Int.random(in: 30...60), Int.random(in: 30...60)], op: op)
        case .hard:
            return MathQuestion(numbers: [
                Int.random(in: 20...50),
                Int.random(in: 20...50),
                Int.random(in: 20...50)
            ], op: op)
        case .veryHard:
            return MathQuestion(numbers: [Int.random(in: 100...999), Int.random(in: 100...999)], op: op)
        }
    }
}


