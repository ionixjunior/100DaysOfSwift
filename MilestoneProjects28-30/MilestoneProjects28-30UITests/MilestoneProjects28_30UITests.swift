import XCTest

final class MilestoneProjects28_30UITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .landscapeLeft
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func testFlipAllCorrectCards() throws {
        let numberOfCards = 32
        let numberOfPairs = numberOfCards / 2
        
        for cardGroup in 1...numberOfPairs {
            let cardIdentifier = "card_\(cardGroup)"
            app.buttons.matching(identifier: cardIdentifier).element(boundBy: 0).tap()
            app.buttons.matching(identifier: cardIdentifier).element(boundBy: 1).tap()
        }
    }
}
