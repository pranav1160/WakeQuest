import Foundation
import Combine

class MathViewModel: ObservableObject {
    
    let totalQuestion: Int
    let difficulty: Difficulty
    
    @Published var currentQuestion: MathQuestion
    @Published var currentIndex: Int = 0
    @Published var timeRemaining: Int = 30
    @Published var showAlarmView: Bool = false
    @Published var shouldDismiss: Bool = false
    @Published var answerRemark: String = ""
    
    private var questions: [MathQuestion] = []
    private var timer: Timer?
    
    var timerProgress: CGFloat {
        CGFloat(timeRemaining) / 30.0
    }
    
    // MARK: - Init
    init(totalQuestion: Int, difficulty: Difficulty) {
        self.totalQuestion = totalQuestion
        self.difficulty = difficulty
        
        let generatedQuestions = MathQuestionGenerator.generateQuestions(
            count: totalQuestion,
            level: difficulty
        )
        
        self.questions = generatedQuestions
        self.currentQuestion = generatedQuestions[0]
    }
    
    // MARK: - Answer submission
    func submitAnswer(_ answer: Int) {
        if answer == currentQuestion.answer {
            answerRemark = "✅ Correct"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.goToNextQuestion()
            }
        } else {
            handleWrongAnswer()
        }
    }
    
    // MARK: - Timer logic
    func startTimer() {
        stopTimer()
        timeRemaining = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timeRemaining -= 1
            if self.timeRemaining == 0 {
                self.handleTimeOut()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Question flow
    func goToNextQuestion() {
        stopTimer()
        answerRemark = ""
        currentIndex += 1
        
        if currentIndex >= totalQuestion {
            shouldDismiss = true
        } else {
            currentQuestion = questions[currentIndex]
            startTimer()
        }
    }
    
    // MARK: - Wrong answer
    func handleWrongAnswer() {
        answerRemark = "❌ Wrong"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.answerRemark = ""
        }
        stopTimer()
        startTimer()
    }
    
    // MARK: - Timeout handler
    func handleTimeOut() {
        
        stopTimer()
        showAlarmView = true
    }
}
