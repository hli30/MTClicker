//
//  GameScene.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate:class{
    func playerTapSettings(player:Player)
    func playerTapInventory(player:Player)
    func playerTapBuildings(player:Player)
    func playerTapShop(player:Player)
}

class GameScene: SKScene {
    
    weak var controllerDelegate:GameSceneDelegate?
    var player:Player?
    
    
    override func didMove(to view: SKView)
    {
        if let playerFromUserData = self.userData?.value(forKey: "player") {
            self.player = (playerFromUserData as! Player)
        }
        
       
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
        
        if let name = touchedNode.name
        {
            if name == "shopButton"
            {
                self.controllerDelegate?.playerTapShop(player: self.player!)
                
            } else if name == "itemButton" {
                
                self.controllerDelegate?.playerTapInventory(player: self.player!)
                
            } else if name == "settingsButton" {
                
                self.controllerDelegate?.playerTapSettings(player: self.player!)
                
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
        
    }
}
