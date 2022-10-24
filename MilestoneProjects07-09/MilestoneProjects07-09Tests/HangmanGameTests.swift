import XCTest
@testable import MilestoneProjects07_09

final class HangmanGameTests: XCTestCase {
    var hangmanGame: HangmanGame!
    let word = "headphone"
    
    override func setUpWithError() throws {
        hangmanGame = HangmanGame()
    }

    override func tearDownWithError() throws {
    }
    
    func testMaskedWordShouldNotRevealWordWhenGameStart() throws {
        hangmanGame.start(word: word)
        
        let result = hangmanGame.getMaskedWord()
        
        XCTAssertEqual("_ _ _ _ _ _ _ _ _", result)
    }
    
    func testMaskedWordShouldRevealTypedLetterWhenItIsCorrect() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "e")
        
        let result = hangmanGame.getMaskedWord()
        
        XCTAssertEqual("_ e _ _ _ _ _ _ e", result)
    }
    
    func testMaskedWordShouldNotRevelAnyLetterWhenItIsIncorrect() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "y")
        
        let result = hangmanGame.getMaskedWord()
        
        XCTAssertEqual("_ _ _ _ _ _ _ _ _", result)
    }
}
