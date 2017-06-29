//
//  PlayerStatsViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-29.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

class PlayerStatsViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var playerLevelTextLabel: UILabel!
    @IBOutlet weak var levelDescriptionTextView: UITextView!
    
    
    var player:Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func levelUpButtonPressed(_ sender: UIButton) {
        player.level += 1 
    }
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
