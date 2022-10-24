class HangmanGame {
    private var word: String!
    
    func start(word: String) {
        self.word = word
    }
    
    func getMaskedWord() -> String {
        var maskedWord = ""
        
        for letter in word {
            maskedWord += "_ "
        }
        
        return maskedWord.trimmingCharacters(in: .whitespaces)
    }
}
