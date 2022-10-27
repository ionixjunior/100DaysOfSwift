import XCTest
@testable import Project01c

class PictureLoaderTests: XCTestCase {
    let content: [String] = ["item1", "item2", "nssl2", "nssl1"]
    
    func testLoadOnlyPicturesPrefixedWithNssl() throws {
        let pictures = PictureLoader.loadPicturesFrom(content: content)
        
        XCTAssertNotEqual("item1", pictures[0].name)
        XCTAssertNotEqual("item2", pictures[0].name)
        XCTAssertNotEqual("item1", pictures[1].name)
        XCTAssertNotEqual("item2", pictures[1].name)
    }
    
    func testSortByName() throws {
        let pictures = PictureLoader.loadPicturesFrom(content: content)
        
        XCTAssertEqual("nssl1", pictures[0].name)
        XCTAssertEqual("nssl2", pictures[1].name)
    }
}
