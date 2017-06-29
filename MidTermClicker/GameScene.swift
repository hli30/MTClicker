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
}

class GameScene: SKScene {
    
    weak var controllerDelegate:GameSceneDelegate?
    var player:Player?
    let gameManager = GameManager()
    var money = 0
    var moneyLabel:SKLabelNode?
    var dirtTileNode:SKTileMapNode?
  
    override func didMove(to view: SKView)
    {
        self.player?.money = money
        if let playerFromUserData = self.userData?.value(forKey: "player") {
            self.player = (playerFromUserData as! Player)
        }
           
        let avatar = self.childNode(withName: "avatarNode") as? SKSpriteNode
        
        guard let avatarData = self.player?.avatar else {
            return
        }
        
        guard let avatarImage = UIImage(data: avatarData) else {
            return
        }
        
        avatar?.texture = SKTexture(image: avatarImage)
        
        self.dirtTileNode = self.childNode(withName: "dirtTileNode") as? SKTileMapNode
        
        self.moneyLabel = self.dirtTileNode?.childNode(withName: "money") as? SKLabelNode
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
        let touchedNode = self.atPoint(positionInScene)
        let realm = try! Realm()
        
        if let name = touchedNode.name
        {
            if name == "shopButton"
            {
                print("tapnode shopbutton")
                try! realm.write {
                    self.player?.money = money
                }
                self.controllerDelegate?.playerTapShop()
                
                
            } else if name == "itemButton" {
                print("tapnode itembutton")
                try! realm.write {
                    self.player?.money = money
                }
                self.controllerDelegate?.playerTapInventory()
                
            } else if name == "settingsButton" {
                print("tapnode settingsbutton")
                try! realm.write {
                    self.player?.money = money
                }
                self.controllerDelegate?.playerTapSettings()
                
            } else if name == "slot1" || name == "slot2" || name == "slot3" {
                print("tapnode slot1/2/3")
                try! realm.write {
                    self.player?.money = money
                }
                self.controllerDelegate?.playerTapBuildings()
            }
        }
        
        money += gameManager.getTapIncome(level:Double((self.player?.level)!))
        self.moneyLabel?.text = String(self.money)
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
        
    }
}
