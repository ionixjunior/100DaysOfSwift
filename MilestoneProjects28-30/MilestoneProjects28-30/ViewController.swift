import UIKit

class ViewController: UIViewController {
    var memoryGame: MemoryGame!
    var closedCardImage = UIImage(named: "card")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cards = [Card]()
        cards.append(Card(name: "Giraffe", group: 1))
        cards.append(Card(name: "Giraffe", group: 1))
        cards.append(Card(name: "Dog", group: 2))
        cards.append(Card(name: "Dog", group: 2))
        cards.append(Card(name: "Cat", group: 3))
        cards.append(Card(name: "Cat", group: 3))
        cards.append(Card(name: "Lion", group: 4))
        cards.append(Card(name: "Lion", group: 4))
        cards.append(Card(name: "Bird", group: 5))
        cards.append(Card(name: "Bird", group: 5))
        cards.append(Card(name: "Chicken", group: 6))
        cards.append(Card(name: "Chicken", group: 6))
        cards.append(Card(name: "Elephant", group: 7))
        cards.append(Card(name: "Elephant", group: 7))
        cards.append(Card(name: "Snake", group: 8))
        cards.append(Card(name: "Snake", group: 8))
        cards.append(Card(name: "Tiger", group: 9))
        cards.append(Card(name: "Tiger", group: 9))
        cards.append(Card(name: "Zebra", group: 10))
        cards.append(Card(name: "Zebra", group: 10))
        cards.append(Card(name: "Horse", group: 11))
        cards.append(Card(name: "Horse", group: 11))
        cards.append(Card(name: "Goat", group: 12))
        cards.append(Card(name: "Goat", group: 12))
        cards.append(Card(name: "Monkey", group: 13))
        cards.append(Card(name: "Monkey", group: 13))
        cards.append(Card(name: "Fish", group: 14))
        cards.append(Card(name: "Fish", group: 14))
        cards.append(Card(name: "Fox", group: 15))
        cards.append(Card(name: "Fox", group: 15))
        cards.append(Card(name: "Rabbit", group: 16))
        cards.append(Card(name: "Rabbit", group: 16))
        
        memoryGame = MemoryGame(cards: cards)
        memoryGame.start()
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = Int(screenRect.size.width)
        let screenHeight = Int(screenRect.size.height)
        
        let cardContentWidth = 120
        let cardContentHeight = 170
        let spaceBetweenCards = 10
        let numberOfRows = 4
        let numberOfColumns = 8
        let cardContainerWidth = screenWidth - ((cardContentWidth + spaceBetweenCards) * numberOfColumns)
        let cardContainerHeight = screenHeight - ((cardContentHeight + spaceBetweenCards) * numberOfRows)
        var xPosition = cardContainerWidth / 2
        var yPosition = cardContainerHeight / 2
        let rangeOfRows = 1...numberOfRows
        let rangeOfColumns = 1...numberOfColumns
        var cardPosition = 1
        
        for row in rangeOfRows {
            if row != rangeOfRows.first {
                yPosition += cardContentHeight + spaceBetweenCards
                xPosition = cardContainerWidth / 2
            }
            
            for column in rangeOfColumns {
                if column != rangeOfColumns.first {
                    xPosition += cardContentWidth + spaceBetweenCards
                }
                
                let card = UICardButton(frame: CGRect(x: xPosition, y: yPosition, width: cardContentWidth, height: cardContentHeight))
                card.backgroundColor = UIColor.gray
                card.layer.cornerRadius = 10
                card.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                card.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                card.setImage(closedCardImage, for: .normal)
                card.position = cardPosition
                view.addSubview(card)
                cardPosition += 1
            }
        }
        
        var cardIndex = 0
        for card in view.subviews.compactMap({ $0 as? UICardButton }) {
            card.accessibilityIdentifier = "card_\(memoryGame.cards[cardIndex].group)"
            cardIndex += 1
        }
    }
    
    var flippedCards = [UICardButton]()

    @objc func cardTapped(_ sender: UICardButton) {
        flippedCards.append(sender)
        let result = memoryGame.flipCardFrom(position: sender.position)
        
        let animationOptions: UIView.AnimationOptions = [.transitionFlipFromLeft]
        UIView.transition(with: sender, duration: 0.5, options: animationOptions, animations: nil, completion: nil)
        sender.setTitle(result.card.name, for: .normal)
        
        if result.flipResult == FlipResult.DoesNotMatch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.transition(with: self.flippedCards.first!, duration: 0.5, options: animationOptions, animations: nil, completion: nil)
                UIView.transition(with: self.flippedCards.last!, duration: 0.5, options: animationOptions, animations: nil, completion: nil)
                self.flippedCards.first?.setTitle("", for: .normal)
                self.flippedCards.last?.setTitle("", for: .normal)
                self.flippedCards.removeAll(keepingCapacity: true)
            }
        }
        
        if result.flipResult == FlipResult.Match {
            flippedCards.first?.isUserInteractionEnabled = false
            flippedCards.last?.isUserInteractionEnabled = false
            flippedCards.removeAll(keepingCapacity: true)
        }
    }
}
