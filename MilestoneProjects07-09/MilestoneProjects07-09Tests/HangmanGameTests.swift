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
    
    func testLivesShouldBe7WhenGameStart() throws {
        hangmanGame.start(word: word)
        
        let result = hangmanGame.getLives()
        
        XCTAssertEqual(7, result)
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
    
    func testTypeShouldBeTrueWhenLetterIsCorrect() throws {
        hangmanGame.start(word: word)
        
        let result = hangmanGame.type(letter: "e")
        
        XCTAssertTrue(result)
    }
    
    func testTypeShouldBeFalseWhenLetterIsIncorrect() throws {
        hangmanGame.start(word: word)
        
        let result = hangmanGame.type(letter: "y")
        
        XCTAssertFalse(result)
    }
    
    func testNumberOfLivesShouldBeTheSameWhenLetterIsCorrect() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "e")
        
        let result = hangmanGame.getLives()
        
        XCTAssertEqual(7, result)
    }
    
    func testOneLiveShouldBeLostWhenLetterIsIncorrect() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "y")
        
        let result = hangmanGame.getLives()
        
        XCTAssertEqual(6, result)
    }
    
    func testShouldRevealTheWordWhenTypeAllLettersCorrect() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "h")
        _ = hangmanGame.type(letter: "e")
        _ = hangmanGame.type(letter: "a")
        _ = hangmanGame.type(letter: "d")
        _ = hangmanGame.type(letter: "p")
        _ = hangmanGame.type(letter: "o")
        _ = hangmanGame.type(letter: "n")
        
        let result = hangmanGame.getMaskedWord()
        
        XCTAssertEqual("h e a d p h o n e", result)
    }
    
    func testAllTypedLettersShouldBeShow() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "h")
        _ = hangmanGame.type(letter: "y")
        
        let result = hangmanGame.getTypedLetters()
        
        XCTAssertEqual("h - y", result)
    }
    
    func testMaskedWordShoulBeUpdatedWhenGameStart() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "e")
        hangmanGame.start(word: "pen")
        
        let result = hangmanGame.getMaskedWord()
        
        XCTAssertEqual("_ _ _", result)
    }
    
    func testLivesShouldBeResetWhenGameStart() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "y")
        hangmanGame.start(word: "pen")
        
        let result = hangmanGame.getLives()
        
        XCTAssertEqual(7, result)
    }
    
    func testAllTypedLettersShouldBeEmptyWhenGameStart() throws {
        hangmanGame.start(word: word)
        _ = hangmanGame.type(letter: "h")
        _ = hangmanGame.type(letter: "y")
        hangmanGame.start(word: "pen")
        
        let result = hangmanGame.getTypedLetters()
        
        XCTAssertEqual("", result)
    }
}
