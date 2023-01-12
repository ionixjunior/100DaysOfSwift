class MemoryGame {
    var cards: [Card]!
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func start() {
        self.cards = self.cards.shuffled()
    }
    
    var flipedCards = [Card]()
    
    func flipCardFrom(position: Int) -> FlipResult {
        flipedCards.append(cards[position - 1])
        
        if flipedCards.count == 1 {
            return FlipResult.Next
        }
        
        if flipedCards.first == flipedCards.last {
            flipedCards.removeAll(keepingCapacity: true)
            return FlipResult.Match
        }
        
        flipedCards.removeAll(keepingCapacity: true)
        return FlipResult.DoesNotMatch
    }
}
