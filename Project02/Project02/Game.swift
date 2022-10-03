class Game {
    private var _score: Int!
    private var _answeredQuestions: Int!
    private var _correctAnswer = 0
    private var _options = [String]()
    
    init(options: [String]) {
        _options = options
    }
    
    var score: Int {
        _score
    }
    
    var answeredQuestions: Int {
        _answeredQuestions
    }
    
    func start() {
        _score = 0
        _answeredQuestions = 0
    }
}
