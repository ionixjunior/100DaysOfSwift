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
    
    func testItemShouldBeAddedIntoList() throws {
        let item = "new item"
        
        shoppingList.add(item: item)
        
        XCTAssertTrue(shoppingList.items.contains(item))
    }
    
    func testClearShouldBeEmptyItems() throws {
        shoppingList.add(item: "item 1")
        shoppingList.add(item: "item 2")
        
        shoppingList.clear()
        
        XCTAssertEqual(0, shoppingList.items.count)
    }
    
    func testGetPlainTextShouldBeGetATextWithTheList() throws {
        let item1 = "item 1"
        let item2 = "item 2"
        shoppingList.add(item: item1)
        shoppingList.add(item: item2)
        
        let result = shoppingList.getPlainText()
        
        XCTAssertEqual("- \(item1)\n- \(item2)", result)
    }
}
