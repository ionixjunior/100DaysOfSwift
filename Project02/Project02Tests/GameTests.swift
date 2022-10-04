import XCTest
@testable import Project02

final class GameTests: XCTestCase {
    var game: Game!
    let options = ["Option 1", "Option 2", "Option 3"]
    
    override func setUpWithError() throws {
        game = Game(options: options)
    }
    
    func testStartShouldGetScore() throws {
        _ = game.start()
        
        XCTAssertEqual(0, game.score)
    }
    
    func testStartShouldGetAnsweredQuestions() throws {
        _ = game.start()
        
        XCTAssertEqual(0, game.answeredQuestions)
    }
    
    func testStartShouldGetThreeOptions() throws {
        let result = game.start()
        
        XCTAssertTrue(options.contains(result.option1))
        XCTAssertTrue(options.contains(result.option2))
        XCTAssertTrue(options.contains(result.option3))
    }
    
    func testAnswerShouldBeTrue() throws {
        _ = game.start()
        let correctAnswer = game.correctAnswer
        
        let result = game.answer(correctAnswer)
        
        XCTAssertTrue(result)
    }
    
    func testAnswerShouldBeFalse() throws {
        _ = game.start()
        let wrongAnswer = 100
        
        let result = game.answer(wrongAnswer)
        
        XCTAssertFalse(result)
    }
    
    func testAnswerCorrectlyShouldIncrementScore() throws {
        _ = game.start()
        let correctAnswer = game.correctAnswer
        
        _ = game.answer(correctAnswer)
        
        XCTAssert(game.score == 1)
    }
    
    func testAnswerCorrectShouldDecrementScore() throws {
        _ = game.start()
        let wrongAnswer = 100
        
        _ = game.answer(wrongAnswer)
        
        XCTAssert(game.score == -1)
    }
    
    func testHasMoreQuestionsShouldBeTrueWhenLimitIsNotReached() throws {
        _ = game.start()
        
        let result = game.hasMoreQuestions()
        
        XCTAssertTrue(result)
    }
    
    func testHasMoreQuestionsShouldBeFalseWhenLimitIsReached() throws {
        _ = game.start()
        let anyAnswer = 0
        for _ in 1...10 {
            _ = game.answer(anyAnswer)
        }
        
        let result = game.hasMoreQuestions()
        
        XCTAssertFalse(result)
    }
}
