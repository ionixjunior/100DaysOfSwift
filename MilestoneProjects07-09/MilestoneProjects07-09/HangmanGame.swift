class HangmanGame {
    private var word: String!
    private var typedLetters = [String]()
    private let maxNumberOfLives = 7
    private var lives: Int!
    
    init() {
        lives = maxNumberOfLives
    }
    
    func start(word: String) {
        self.word = word
        typedLetters.removeAll()
        lives = maxNumberOfLives
    }
    
    func getMaskedWord() -> String {
        var maskedWord = ""
        
        for letter in word {
            if typedLetters.contains(String(letter)) {
                maskedWord += "\(letter) "
            } else {
                maskedWord += "_ "
            }
        }
        
        return maskedWord.trimmingCharacters(in: .whitespaces)
    }
    
    func type(letter: String) -> Bool {
        typedLetters.append(letter)
        let letterExists = word.contains(letter)
        
        if letterExists == false {
            lives -= 1
        }
        
        return letterExists
    }
    
    func getLives() -> Int {
        return lives
    }
}
