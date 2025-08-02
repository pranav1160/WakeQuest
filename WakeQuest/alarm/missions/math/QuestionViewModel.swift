import Foundation

class QuestionViewModel: ObservableObject {
    
    @Published var questionText: String = ""
    @Published var currentQuestion: Question?
    @Published var currentAnswer: Int?
    @Published var message: String?
    @Published var options: [Int] = []
    
    init() {
        generateQuestion()
    }
    
    func generateQuestion() {
        var newQuestion: Question
        
        // Ensure valid division
        repeat {
            let x = Int.random(in: 1...50)
            let y = Int.random(in: 1...50)
            let op = Operator.allCases.randomElement()!
            
            newQuestion = Question(x: x, y: y, op: op)
        } while newQuestion.op == .divide && (newQuestion.y == 0 || newQuestion.x % newQuestion.y != 0)
        
        currentQuestion = newQuestion
        currentAnswer = newQuestion.answer
        questionText = newQuestion.text
        generateOptions()
    }
    
    func generateOptions() {
        guard let correct = currentAnswer else { return }
        
        options = [correct]
        while options.count < 3 {
            let variation = Int.random(in: -10...10)
            let candidate = correct + variation
            
            if candidate != correct && !options.contains(candidate) && candidate >= 0 {
                options.append(candidate)
            }
        }
        
        options.shuffle()
    }
    
    func checkAnswer(_ userAnswer: Int) {
        guard let question = currentQuestion else { return }
        message = (userAnswer == question.answer) ? "✅ Correct!" : "❌ Try again"
    }
}
