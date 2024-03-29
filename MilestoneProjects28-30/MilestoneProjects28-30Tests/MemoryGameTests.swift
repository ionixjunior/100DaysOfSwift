import XCTest
import UIKit
@testable import MilestoneProjects28_30

final class MemoryGameTests: XCTestCase {
    var cards: [Card]!
    
    override func setUpWithError() throws {
        cards = [Card]()
        cards.append(Card(image: UIImage(named: "dog")!, group: 1))
        cards.append(Card(image: UIImage(named: "dog")!, group: 1))
        cards.append(Card(image: UIImage(named: "cat")!, group: 2))
        cards.append(Card(image: UIImage(named: "cat")!, group: 2))
        cards.append(Card(image: UIImage(named: "horse")!, group: 3))
        cards.append(Card(image: UIImage(named: "horse")!, group: 3))
    }

    override func tearDownWithError() throws {
    }

    func testStartGameShouldShuffleCards() throws {
        let memoryGame = MemoryGame(cards: cards)
        
        memoryGame.start()
        
        XCTAssertNotEqual(memoryGame.cards, self.cards)
    }
    
    func testFlipCardShouldReturnNextWhenFlipTheFirstCard() throws {
        let memoryGame = MemoryGame(cards: cards)
        
        let result = memoryGame.flipCardFrom(position: 1)
        
        XCTAssertTrue(FlipResult.Next == result.flipResult)
    }
    
    func testFlipCardShouldReturnMatchWhenFlipTheSecondCard() throws {
        let memoryGame = MemoryGame(cards: cards)
        _ = memoryGame.flipCardFrom(position: 1)
        
        let result = memoryGame.flipCardFrom(position: 2)
        
        XCTAssertTrue(FlipResult.Match == result.flipResult)
    }
    
    func testFlipCardShouldReturnDoesNotMatchWhenFlipTheSecondCard() throws {
        let memoryCard = MemoryGame(cards: cards)
        memoryCard.start()
        _ = memoryCard.flipCardFrom(position: 1)
        
        let result = memoryCard.flipCardFrom(position: 2)
        
        XCTAssertTrue(FlipResult.DoesNotMatch == result.flipResult)
    }
}
