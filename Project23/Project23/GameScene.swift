import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var gameScore: SKLabelNode!
    
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var livesImages = [SKSpriteNode]()
    var lives = 3
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.blendMode = .replace
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
        
        createScore()
        createLives()
    }
    
    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        gameScore.position = CGPoint(x: 8, y: 8)
        score = 0
        addChild(gameScore)
    }
    
    func createLives() {
        for i in 0..<3 {
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
            addChild(spriteNode)
            livesImages.append(spriteNode)
        }
    }
}
