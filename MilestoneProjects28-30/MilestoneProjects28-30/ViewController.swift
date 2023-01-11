import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        for row in rangeOfRows {
            if row != rangeOfRows.first {
                yPosition += cardContentHeight + spaceBetweenCards
                xPosition = cardContainerWidth / 2
            }
            
            for column in rangeOfColumns {
                if column != rangeOfColumns.first {
                    xPosition += cardContentWidth + spaceBetweenCards
                }
                
                let card = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: cardContentWidth, height: cardContentHeight))
                card.backgroundColor = UIColor.gray
                card.layer.cornerRadius = 10
                card.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                view.addSubview(card)
            }
        }
    }

    @objc func cardTapped(_ sender: UIButton) {
        let animationOptions: UIView.AnimationOptions = [.transitionFlipFromLeft]
        UIView.transition(with: sender, duration: 0.5, options: animationOptions, animations: nil, completion: nil)
    }
}
