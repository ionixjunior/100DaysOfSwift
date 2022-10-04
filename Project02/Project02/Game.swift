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
    
    func start() -> (option1: String, option2: String, option3: String) {
        _score = 0
        _answeredQuestions = 0
        _options.shuffle()
        _correctAnswer = Int.random(in: 0...2)
        return (option1: _options[0], option2: _options[1], option3: _options[2])
    }
}
