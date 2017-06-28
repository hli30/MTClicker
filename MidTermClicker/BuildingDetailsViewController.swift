//
//  BuildingDetailsViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

class BuildingDetailsViewController: UIViewController {

    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var buildingImageView: UIImageView!
    @IBOutlet weak var currentDetailsTextView: UITextView!
    @IBOutlet weak var nextDetailsTextView: UITextView!
    
    var building:Buildings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDetailsTextView.text = building?.upgradeDescription
        
    }
    
    @IBAction func upgradeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func sellButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
    }
    
}
