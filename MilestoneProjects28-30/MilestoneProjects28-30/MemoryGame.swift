class MemoryGame {
    var cards: [Card]!
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func start() {
        self.cards = self.cards.shuffled()
    }
    
    var flipedCards = [Card]()
    
    func flipCardFrom(position: Int) -> (flipResult: FlipResult, card: Card) {
        let card = cards[position - 1]
        flipedCards.append(card)
        
        if flipedCards.count == 1 {
            return (FlipResult.Next, card)
        }
        
        if flipedCards.first == flipedCards.last {
            flipedCards.removeAll(keepingCapacity: true)
            return (FlipResult.Match, card)
        }
        
        flipedCards.removeAll(keepingCapacity: true)
        return (FlipResult.DoesNotMatch, card)
    }
}
