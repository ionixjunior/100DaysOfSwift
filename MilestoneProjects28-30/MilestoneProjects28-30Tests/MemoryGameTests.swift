import XCTest
@testable import MilestoneProjects28_30

final class MemoryGameTests: XCTestCase {
    var cards: [Card]!
    
    override func setUpWithError() throws {
        cards = [Card]()
        cards.append(Card(name: "Card 1A", group: 1))
        cards.append(Card(name: "Card 1B", group: 1))
        cards.append(Card(name: "Card 2A", group: 2))
        cards.append(Card(name: "Card 2B", group: 2))
        cards.append(Card(name: "Card 3A", group: 3))
        cards.append(Card(name: "Card 3B", group: 3))
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
        
        XCTAssertTrue(FlipResult.Next == result)
    }
    
    func testFlipCardShouldReturnMatchWhenFlipTheSecondCard() throws {
        let memoryGame = MemoryGame(cards: cards)
        _ = memoryGame.flipCardFrom(position: 1)
        
        let result = memoryGame.flipCardFrom(position: 2)
        
        XCTAssertTrue(FlipResult.Match == result)
    }
    
    func testFlipCardShouldReturnDoesNotMatchWhenFlipTheSecondCard() throws {
        let memoryCard = MemoryGame(cards: cards)
        memoryCard.start()
        _ = memoryCard.flipCardFrom(position: 1)
        
        let result = memoryCard.flipCardFrom(position: 2)
        
        XCTAssertTrue(FlipResult.DoesNotMatch == result)
    }
}
