import XCTest
@testable import Project02

final class GameTests: XCTestCase {
    var game: Game!
    
    override func setUpWithError() throws {
        game = Game(options: ["Option 1", "Option 2", "Option 3"])
    }
}
