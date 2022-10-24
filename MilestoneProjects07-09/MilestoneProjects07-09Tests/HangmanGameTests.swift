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
    
    func testShowMaskedWordWhenGameStart() throws {
        hangmanGame.start(word: word)
        
        let result = hangmanGame.getMaskedWord()
        
        XCTAssertEqual(" ?  ?  ?  ?  ?  ?  ?  ?  ? ", result)
    }
}
