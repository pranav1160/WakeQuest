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
        }
    }
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
