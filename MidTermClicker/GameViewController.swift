//
//  GameViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import RealmSwift

class GameViewController: UIViewController {
    var player:Player!
    var delegate:GameSceneDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        
        let playerQuery = realm.objects(Player.self)
        
        self.player = playerQuery.first
        
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                
                // Delegate
                scene.controllerDelegate = self
                
                // Pass player to scene
                scene.userData = NSMutableDictionary()
                scene.userData?.setObject(self.player, forKey: "player" as NSCopying)
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// MARK: GameSceneDelegate
extension GameViewController: GameSceneDelegate {
    func playerTapSettings() {
        self.performSegue(withIdentifier: "showSettings", sender: self)
    }
    func playerTapInventory() {
        self.performSegue(withIdentifier: "showInventory", sender: self)
    }
    func playerTapBuildings() {
        self.performSegue(withIdentifier: "showUpgrades", sender: self)
    }
    func playerTapShop() {
        self.performSegue(withIdentifier: "showShop", sender: self)
    }
    func playerTapAvatar() {
        self.performSegue(withIdentifier: "showPlayerStats", sender: self)
    }
}

// MARK: Segue
extension GameViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShop" {
            if let destinationVC = segue.destination as? ShopViewController {
                destinationVC.player = self.player
            }
        }
        
        if segue.identifier == "showInventory" {
            if let destinationVC = segue.destination as? InventoryViewController {
                destinationVC.player = self.player
            }
        }
        
        if segue.identifier == "showSettings" {
            if let destinationVC = segue.destination as? SettingsViewController {
                destinationVC.player = self.player
            }
        }
        
        if segue.identifier == "showUpgrades" {
            if let destinationVC = segue.destination as? UpgradeViewController {
                destinationVC.player = self.player
            }
        }
        
        if segue.identifier == "showPlayerStats" {
            if let destinationVC = segue.destination as? PlayerStatsViewController {
                destinationVC.player = self.player
            }
        }
    }
}
