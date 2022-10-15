import XCTest
@testable import MilestoneProjects04_06

final class ShoppingListTests: XCTestCase {
    var shoppingList: ShoppingList!
    
    override func setUpWithError() throws {
        shoppingList = ShoppingList()
    }

    override func tearDownWithError() throws {
    }
    
    func testItemsShouldBeEmptyAtStart() throws {
        XCTAssertEqual(0, shoppingList.items.count)
    }
}
