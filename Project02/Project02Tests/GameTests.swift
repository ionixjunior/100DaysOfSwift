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
}
