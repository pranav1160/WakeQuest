import Foundation

struct MathQuestion {
    let numbers: [Int]
    let op: Operator
    
    var text: String {
        numbers.map(String.init).joined(separator: " \(op.symbol) ")
    }
    
    var answer: Int {
        switch op {
        case .add:
            return numbers.reduce(0, +)
        case .subtract:
            return numbers.dropFirst().reduce(numbers.first ?? 0, -)
        }
    }
    
    static let samples:[MathQuestion]=[ MathQuestion(numbers: [5, 4], op: .add),
                                        MathQuestion(numbers: [20, 5], op: .add),
                                        MathQuestion(numbers: [45, 14], op: .add),
                                        MathQuestion(numbers: [34, 45, 76], op: .add),
                                        MathQuestion(numbers: [345, 678], op: .add)]
    
}




enum Operator: String, CaseIterable {
    case add, subtract
    
    var symbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        }
    }
}

enum Difficulty:Int,CaseIterable {
    case veryEasy=0, easy, normal, hard, veryHard
    
    var label: String {
        switch self {
        case .veryEasy: return " 🟢 Very Easy"
        case .easy: return " 🟡 Easy"
        case .normal: return " 🟠 Normal"
        case .hard: return " 🔴 Hard"
        case .veryHard: return " 💀 Very Hard"
        }
    }
}

