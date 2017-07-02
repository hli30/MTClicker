//
//  PlayerStatsViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-29.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit
import RealmSwift

class PlayerStatsViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var playerLevelTextLabel: UILabel!
    @IBOutlet weak var levelDescriptionTextView: UITextView!
    
    
    var player:Player!
    let outputFormatter = OutPutFormatter()
    var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLevelTextview()
        
        guard let avatarData = self.player.avatar else {
            return
        }
        
        guard let avatarImage = UIImage(data: avatarData) else {
            return
        }
        
        avatarImageView.image = avatarImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func levelUpButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController.init(title: "Purchase Confirmation",
                                                     message: "$\(round(player.levelCost))0 will be deducted",
            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if player.money >= player.levelCost {
            alertController.addAction(UIAlertAction.init(title: "Confirm",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(alertController:UIAlertAction) in
                                                            
                                                            let realm = try! Realm()
                                                            
                                                            let newMoney = self.player.money - self.player.levelCost
                                                            
                                                            try! realm.write {
                                                                self.player.level += 1
                                                                self.player.money = newMoney
                                                                self.player.levelCost = self.gameManager.getPlayerLevelCost(player:self.player)
                                                            }
                                                            
                                                            
                                                            self.updateLevelTextview()
                                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewControlledClosed"), object: nil)
                                                            
                                                            
            }))
        } else {
            alertController.addAction(UIAlertAction.init(title: "Insufficient Funds",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(alertController:UIAlertAction) in
                                                            
            }))
        }
        
        alertController.addAction(UIAlertAction.init(title: "Cancel",
                                                     style: UIAlertActionStyle.cancel,
                                                     handler: { (alertController:UIAlertAction) in
                                                        
        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateLevelTextview() {
        levelDescriptionTextView.text = outputFormatter.playerStatsFormatter(user: player)
        playerLevelTextLabel.text = "Level: \(player.level)"
    }

}
