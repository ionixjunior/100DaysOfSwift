class HangmanGame {
    private var word: String!
    private var typedLetters = [String]()
    private var lives = 7
    
    func start(word: String) {
        self.word = word
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
        return word.contains(letter)
    }
    
    func getLives() -> Int {
        return lives
    }
}
