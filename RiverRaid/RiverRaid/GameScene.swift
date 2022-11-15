import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 375, y: 667)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        let plane = SKSpriteNode(imageNamed: "plane")
        plane.position = CGPoint(x: 375, y: 100)
        addChild(plane)
    }

    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
