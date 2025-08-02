import Foundation

struct Question {
    let x: Int
    let y: Int
    let op: Operator
    
    var text: String {
        "\(x) \(op.symbol) \(y)"
    }
    
    var answer: Int {
        switch op {
        case .add: return x + y
        case .subtract: return x - y
        case .multiply: return x * y
        case .divide:
            // Return floor division only if divisible
            return y != 0 ? x / y : 0
        }
    }
}

enum Operator: String, CaseIterable {
    case add, subtract, multiply, divide
    
    var symbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}
