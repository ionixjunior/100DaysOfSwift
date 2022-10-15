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
    
    func testPlainTextShouldBeATextWithTheItems() throws {
        let item1 = "item 1"
        let item2 = "item 2"
        shoppingList.add(item: item1)
        shoppingList.add(item: item2)
        
        let result = shoppingList.plainText
        
        XCTAssertEqual("- \(item2)\n- \(item1)", result)
    }
    
    func testTotalShouldBeTotalOfInsertedItems() throws {
        shoppingList.add(item: "item 1")
        
        let result = shoppingList.total
        
        XCTAssertEqual(1, result)
    }
    
    func testItemFromShouldGetTheItemFromList() throws {
        let item1 = "item 1"
        let item2 = "item 2"
        shoppingList.add(item: item1)
        shoppingList.add(item: item2)
        
        let result = shoppingList.itemFrom(position: 1)
        
        XCTAssertEqual(item1, result)
    }
    
    func testNewItemsShouldBeOnTopOfTheList() throws {
        let item1 = "item 1"
        let item2 = "item 2"
        shoppingList.add(item: item1)
        shoppingList.add(item: item2)
        
        let itemOfPosition0 = shoppingList.itemFrom(position: 0)
        let itemOfPosition1 = shoppingList.itemFrom(position: 1)
        
        XCTAssertEqual(item2, itemOfPosition0)
        XCTAssertEqual(item1, itemOfPosition1)
    }
}
