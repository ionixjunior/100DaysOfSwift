import XCTest

final class MilestoneProjects04_06UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testApp() throws {
        let app = XCUIApplication()
        app.launch()
        
        let item1 = "Potato"
        let item2 = "Tomato"
        app.navigationBars.buttons["Add"].tap()
        app.textFields.firstMatch.typeText(item1)
        app.alerts.buttons["Add"].tap()
        XCTAssertTrue(app.tables.firstMatch.cells.element(boundBy: 0).staticTexts[item1].exists)
        
        app.navigationBars.buttons["Add"].tap()
        app.textFields.firstMatch.typeText(item2)
        app.alerts.buttons["Add"].tap()
        XCTAssertTrue(app.tables.firstMatch.cells.element(boundBy: 0).staticTexts[item2].exists)
        
        app.buttons["Share"].tap()
        app.buttons["Close"].tap()
        
        app.navigationBars.buttons["Delete"].tap()
        app.alerts.buttons["Yes"].tap()
        XCTAssertFalse(app.tables.cells.element(boundBy: 0).exists)
    }
}
