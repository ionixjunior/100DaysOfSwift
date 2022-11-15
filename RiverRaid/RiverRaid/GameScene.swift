import SpriteKit

class GameScene: SKScene {
    var plane: SKSpriteNode!
    
    var gameTimer: Timer?
    var planeTimer: Timer?
    var objects = ["helicopter", "ship"]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 375, y: 667)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        plane = SKSpriteNode(imageNamed: "plane")
        plane.position = CGPoint(x: 375, y: 100)
        plane.physicsBody = SKPhysicsBody(texture: plane.texture!, size: plane.size)
        plane.physicsBody?.affectedByGravity = false
        addChild(plane)
        
        let leftButton = SKSpriteNode(imageNamed: "left")
        leftButton.name = "left"
        leftButton.position = CGPoint(x: 50, y: 50)
        addChild(leftButton)
        
        let rightButton = SKSpriteNode(imageNamed: "right")
        rightButton.name = "right"
        rightButton.position = CGPoint(x: 150, y: 50)
        addChild(rightButton)
        
        let fireButton = SKSpriteNode(imageNamed: "fire")
        fireButton.name = "fire"
        fireButton.position = CGPoint(x: 700, y: 50)
        addChild(fireButton)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createObject), userInfo: nil, repeats: true)
    }
    
    @objc func createObject() {
        guard let object = objects.randomElement() else { return }

        let sprite = SKSpriteNode(imageNamed: object)
        sprite.position = CGPoint(x: Int.random(in: 200...550), y: 1400)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        addChild(sprite)
    }

    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "left" {
            planeTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(moveLeft), userInfo: nil, repeats: true)
        } else if node.name == "right" {
            planeTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(moveRight), userInfo: nil, repeats: true)
        } else if node.name == "fire" {
            let sprite = SKSpriteNode(imageNamed: "bullet")
            sprite.name = "bullet"
            sprite.position = CGPoint(x: plane.position.x, y: 200)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            addChild(sprite)
            sprite.run(SKAction.moveTo(y: 1500, duration: 1))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "left" {
            planeTimer?.invalidate()
        } else if node.name == "right" {
            planeTimer?.invalidate()
        } else if node.name == "fire" {
            print("fire")
        }
    }
    
    @objc func moveLeft() {
        plane.position.x = plane.position.x - 1
    }
    
    @objc func moveRight() {
        plane.position.x = plane.position.x + 1
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.y < -300 {
                node.removeFromParent()
            }
            
            if node.position.y > 1400 {
                node.removeFromParent()
            }
        }
    }
}
