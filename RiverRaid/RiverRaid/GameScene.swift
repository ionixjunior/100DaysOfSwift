import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 375, y: 667)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }

    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
