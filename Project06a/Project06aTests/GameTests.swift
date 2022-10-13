import XCTest
@testable import Project06a

final class GameTests: XCTestCase {
    var game: Game!
    let options = ["Option 1", "Option 2", "Option 3"]
    
    override func setUpWithError() throws {
        game = Game(options: options)
    }
    
    func testStartShouldGetInitialScore() throws {
        _ = game.start()
        
        XCTAssertEqual(0, game.score)
    }
    
    func testStartShouldGetAnsweredQuestionsEqualsZeroWhenGameStarts() throws {
        _ = game.start()
        
        XCTAssertEqual(0, game.answeredQuestions)
    }
    
    func testStartShouldGetAnsweredQuestionsEquals1WhenAnswerAQuestion() throws {
        _ = game.start()
        let answer = 0
        
        _ = game.answer(answer)
        
        XCTAssertEqual(1, game.answeredQuestions)
    }
    
    func testStartShouldGetThreeOptionsWhenGameStarts() throws {
        let result = game.start()
        
        XCTAssertTrue(options.contains(result.option1))
        XCTAssertTrue(options.contains(result.option2))
        XCTAssertTrue(options.contains(result.option3))
    }
    
    func testAnswerShouldBeTrueWhenAnswerIsCorrect() throws {
        _ = game.start()
        let correctAnswer = game.correctAnswer
        
        let result = game.answer(correctAnswer)
        
        XCTAssertTrue(result)
    }
    
    func testAnswerShouldBeFalseWhenAnswerIsWrong() throws {
        _ = game.start()
        let wrongAnswer = 100
        
        let result = game.answer(wrongAnswer)
        
        XCTAssertFalse(result)
    }
    
    func testCorrectAnswerShouldIncrementScoreWhenAnswerIsCorrect() throws {
        _ = game.start()
        let correctAnswer = game.correctAnswer
        
        _ = game.answer(correctAnswer)
        
        XCTAssert(game.score == 1)
    }
    
    func testCorrectAnswerShouldDecrementScoreWhenAnswerIsWrong() throws {
        _ = game.start()
        let wrongAnswer = 100
        
        _ = game.answer(wrongAnswer)
        
        XCTAssert(game.score == -1)
    }
    
    func testIsOverShouldBeFalseWhenLimitIsNotReached() throws {
        _ = game.start()
        
        let result = game.isOver()
        
        XCTAssertFalse(result)
    }
    
    func testIsOverShouldBeTrueWhenLimitIsReached() throws {
        _ = game.start()
        let anyAnswer = 0
        for _ in 1...10 {
            _ = game.answer(anyAnswer)
        }
        
        let result = game.isOver()
        
        XCTAssertTrue(result)
    }
    
    func testNextQuestionShouldGetThreeOptions() throws {
        _ = game.start()
        
        let result = game.nextQuestion()
        
        XCTAssertTrue(options.contains(result.option1))
        XCTAssertTrue(options.contains(result.option2))
        XCTAssertTrue(options.contains(result.option3))
    }
    
    func testOptionNameShouldGetUppercasedName() throws {
        let id = 0
        
        let result = game.getOptionNameBy(id: id)
        
        XCTAssertEqual(options[0].uppercased(), result)
    }
}
