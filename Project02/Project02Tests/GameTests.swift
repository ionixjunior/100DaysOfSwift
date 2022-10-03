import XCTest
@testable import Project02

final class GameTests: XCTestCase {
    var game: Game!
    
    override func setUpWithError() throws {
        game = Game(options: ["Option 1", "Option 2", "Option 3"])
    }
    
    func testStartShouldGetScore() throws {
        game.start()
        
        XCTAssertEqual(0, game.score)
    }
    
    func testStartShouldGetAnsweredQuestions() throws {
        game.start()
        
        XCTAssertEqual(0, game.answeredQuestions)
    }
}
