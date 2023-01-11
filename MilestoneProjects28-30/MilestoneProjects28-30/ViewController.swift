import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        var xPosition = (Int(screenWidth) - 1040) / 2
        var yPosition = (Int(screenHeight) - 720) / 2
        
        for row in 1...4 {
            if row != 1 {
                yPosition += 180
                xPosition = (Int(screenWidth) - 1040) / 2
            }
            
            for column in 1...8 {
                if column != 1 {
                    xPosition += 130
                }
                
                let card = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: 120, height: 170))
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
