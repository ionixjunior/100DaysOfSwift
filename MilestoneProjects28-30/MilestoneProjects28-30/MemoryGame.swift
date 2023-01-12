class MemoryGame {
    var cards: [Card]!
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func start() {
        self.cards = self.cards.shuffled()
    }
}
