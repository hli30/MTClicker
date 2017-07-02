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
    var scene = GameScene()
    var player:Player!
    var delegate:GameSceneDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        
        let playerQuery = realm.objects(Player.self)
        
        self.player = playerQuery.first
        
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                scene.controllerDelegate = self
            
                scene.userData = NSMutableDictionary()
                scene.userData?.setObject(player, forKey: "player" as NSCopying)
                
                self.scene = scene
                view.presentScene(self.scene)
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
        performSegue(withIdentifier: "showSettings", sender: self)
    }
    func playerTapInventory() {
        performSegue(withIdentifier: "showInventory", sender: self)
    }
    func playerTapBuildings() {
        performSegue(withIdentifier: "showUpgrades", sender: self)
    }
    func playerTapShop() {
        performSegue(withIdentifier: "showShop", sender: self)
    }
    func playerTapAvatar() {
        performSegue(withIdentifier: "showPlayerStats", sender: self)
    }
}

// MARK: Segue
extension GameViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShop" {
            if let destinationVC = segue.destination as? ShopViewController {
                destinationVC.player = player
            }
        }
        
        if segue.identifier == "showInventory" {
            if let destinationVC = segue.destination as? InventoryViewController {
                destinationVC.player = player
            }
        }
        
        if segue.identifier == "showSettings" {
            if let destinationVC = segue.destination as? SettingsViewController {
                destinationVC.player = player
            }
        }
        
        if segue.identifier == "showUpgrades" {
            if let destinationVC = segue.destination as? UpgradeViewController {
                destinationVC.player = player
                destinationVC.delegate = scene
            }
        }
        
        if segue.identifier == "showPlayerStats" {
            if let destinationVC = segue.destination as? PlayerStatsViewController {
                destinationVC.player = player
            }
        }
    }
}
