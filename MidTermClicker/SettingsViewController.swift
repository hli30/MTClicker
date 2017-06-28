//
//  SettingsViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var player:Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func musicVolumeSliderChanged(_ sender: UISlider) {
//        player?.settings?.musicVolume = sender.value
    }
    
    @IBAction func soundFXSliderChanged(_ sender: UISlider) {
//        player?.settings?.soundFXVolume = sender.value
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    

}
