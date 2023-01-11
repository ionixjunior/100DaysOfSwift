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
                
                let card = UIView(frame: CGRect(x: xPosition, y: yPosition, width: 120, height: 170))
                card.backgroundColor = UIColor.gray
                card.layer.cornerRadius = 10
                view.addSubview(card)
            }
        }
    }

}
