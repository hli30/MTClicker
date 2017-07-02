//
//  GameScene.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import SpriteKit
import GameplayKit
import RealmSwift

protocol GameSceneDelegate:class{
    func playerTapSettings()
    func playerTapInventory()
    func playerTapBuildings()
    func playerTapShop()
    func playerTapAvatar()
}

class GameScene: SKScene, UpgradeVCDelegate {
    
    weak var controllerDelegate:GameSceneDelegate?
    var player:Player!
    let gameManager = GameManager()
    var money:Double = 0
    var moneyLabel:SKLabelNode!
    var levelLabel:SKLabelNode!
    var slot1:SKSpriteNode!
    var slot2:SKSpriteNode!
    var slot3:SKSpriteNode!
    var bee = SKSpriteNode()
    var cow = SKSpriteNode()
    var chicken = SKSpriteNode()
    
    
    var selectedNode: SKSpriteNode?
    
    override func sceneDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMoney), name: NSNotification.Name(rawValue: "viewControlledClosed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addAnimal), name: NSNotification.Name(rawValue: "purchasedProperty"), object: nil)
    }
  
    override func didMove(to view: SKView)
    {
        if let playerFromUserData = self.userData?.value(forKey: "player") {
            player = (playerFromUserData as! Player)
        }
        money = player.money

        
        let avatar = self.childNode(withName: "avatarNode") as? SKSpriteNode
        
        guard let avatarData = player.avatar else {
            return
        }
        
        guard let avatarImage = UIImage(data: avatarData) else {
            return
        }
        
        avatar?.texture = SKTexture(image: avatarImage)
        
        moneyLabel = self.childNode(withName: "money") as? SKLabelNode
        levelLabel = self.childNode(withName: "level") as? SKLabelNode
        slot1 = self.childNode(withName: "slot1") as? SKSpriteNode
        slot2 = self.childNode(withName: "slot2") as? SKSpriteNode
        slot3 = self.childNode(withName: "slot3") as? SKSpriteNode

        levelLabel.text = "Level \(String(describing: player.level))"
        moneyLabel.text = "$\(String(Int(money)))"
        
        slot1.color = UIColor.clear
        slot2.color = UIColor.clear
        slot3.color = UIColor.clear
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = atPoint(positionInScene)
        let realm = try! Realm()
        
        if let name = touchedNode.name
        {
            switch name {
            case "shopButton":
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapShop()
            case "settingsButton":
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapSettings()
            case "itemButton":
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapInventory()
            case "avatarNode":
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapAvatar()
            case "slot1":
                selectedNode = slot1
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapBuildings()
            case "slot2":
                selectedNode = slot2
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapBuildings()
            case "slot3":
                selectedNode = slot3
                try! realm.write {
                    player.money = money
                }
                controllerDelegate?.playerTapBuildings()
            default:
                money += gameManager.getTapIncome(level: Double((player.level)), player: player)
                moneyLabel.text = "$\(String(Int(self.money)))"
                clickAnimationAtLocation(positionInScene: positionInScene)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered 
        self.enumerateChildNodes(withName: "coin") { (node, stop) in
            if node.position.y < -667 {
                node.removeFromParent()
            }
        }
    }
    
    // MARK: - NotificationCenter Actions
    func updateMoney(notification:Notification) {
        money = (self.player.money)
        moneyLabel.text = "$\(String(Int(money)))"
        levelLabel.text = "Level \(String(describing: player.level))"
    }
    
    func addAnimal(notification:Notification) {
        let building = notification.userInfo?["building"] as? Buildings
        
        if building?.name == "Farm" {
            addWalkingCow()
        } else if building?.name == "Garden" {
            addTheFlyingBee()
        } else {
            addWalkingChicken()
        }
    }
    
    // MARK: - Delegate for Upgrade Sceeen
    func updateNode(with image: UIImage) {
        selectedNode?.texture = SKTexture(image: image)
    }
    
    // MARK: - Click Animation
    func clickAnimationAtLocation(positionInScene:CGPoint) {
        let scene:SKScene = SKScene(fileNamed: "ClickAnimationCoin")!
        let coin = scene.childNode(withName: "coin")
        coin?.position = positionInScene
        let randAngle:Int = Int(arc4random_uniform(201)) - 100
        coin?.physicsBody?.velocity = CGVector(dx: randAngle, dy: 400)
        
        coin?.move(toParent: self)
        
    }
    
    
    
    // MARK: - Bee Animation
    
    func addTheFlyingBee() {
        
        bee.size = CGSize(width: 50, height: 50)
        bee.position = CGPoint(x: 220, y: 250)
        addChild(bee)
        
        let beeAtlas = SKTextureAtlas(named: "Bees")
        let beeFrames: [SKTexture] = [
            beeAtlas.textureNamed("bee"),
            beeAtlas.textureNamed("bee-fly")]
        let flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.14)
        let beeAction = SKAction.repeatForever(flyAction)
        
        bee.run(beeAction)
        
        let pathLeft = SKAction.moveBy(x: -100, y: -10, duration: 3)
        let pathRight = SKAction.moveBy(x: 100, y: 10, duration: 3)
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        
        let flightOfBee = SKAction.sequence([pathLeft, flipTextureNegative, pathRight, flipTexturePositive])
        let neverEndingFlight = SKAction.repeatForever(flightOfBee)
        
        bee.run(neverEndingFlight)
        
    }
    
    func addWalkingCow() {
        let sheet = SpriteSheet(texture: SKTexture(imageNamed: "cow_walk"), rows: 4, columns: 4, spacing: 1, margin: 1)
        let cowWalkLeft1 = sheet.textureForColumn(column: 0, row: 2)!
        let cowWalkLeft2 = sheet.textureForColumn(column: 1, row: 2)!
        let cowWalkLeft3 = sheet.textureForColumn(column: 2, row: 2)!
        let cowWalkLeft4 = sheet.textureForColumn(column: 3, row: 2)!
        
        cow.size = CGSize(width: 200, height: 200)
        cow.position = CGPoint(x: 0, y: -100)
        addChild(cow)
        
        let cowFrames: [SKTexture] = [
            cowWalkLeft1,
            cowWalkLeft2,
            cowWalkLeft3,
            cowWalkLeft4]
        let walkAction = SKAction.animate(with: cowFrames, timePerFrame: 0.25)
        let cowAction = SKAction.repeatForever(walkAction)
        
        cow.run(cowAction)
        
        let pathLeft = SKAction.moveBy(x: -100, y: -10, duration: 5)
        let pathRight = SKAction.moveBy(x: 100, y: 10, duration: 5)
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        
        let walkOfCow = SKAction.sequence([pathLeft, flipTextureNegative, pathRight, flipTexturePositive])
        let neverEndingWalk = SKAction.repeatForever(walkOfCow)
        
        cow.run(neverEndingWalk)
    }
    
    func addWalkingChicken() {
        let sheet = SpriteSheet(texture: SKTexture(imageNamed: "chicken_walk"), rows: 4, columns: 4, spacing: 1, margin: 1)
        let chickenWalkLeft1 = sheet.textureForColumn(column: 0, row: 2)!
        let chickenWalkLeft2 = sheet.textureForColumn(column: 1, row: 2)!
        let chickenWalkLeft3 = sheet.textureForColumn(column: 2, row: 2)!
        let chickenWalkLeft4 = sheet.textureForColumn(column: 3, row: 2)!
        
        chicken.size = CGSize(width: 100, height: 100)
        chicken.position = CGPoint(x: 0, y: -200)
        addChild(chicken)
        
        let chickenFrames: [SKTexture] = [
            chickenWalkLeft1,
            chickenWalkLeft2,
            chickenWalkLeft3,
            chickenWalkLeft4,
]
        let walkAction = SKAction.animate(with: chickenFrames, timePerFrame: 0.14)
        let chickenAction = SKAction.repeatForever(walkAction)
        
        chicken.run(chickenAction)
        
        let pathLeft = SKAction.moveBy(x: -100, y: -10, duration: 5)
        let pathRight = SKAction.moveBy(x: 100, y: 10, duration: 5)
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        
        let walkOfChicken = SKAction.sequence([pathRight, flipTextureNegative, pathLeft, flipTexturePositive])
        let neverEndingWalk = SKAction.repeatForever(walkOfChicken)
        
        chicken.run(neverEndingWalk)
    }
}

