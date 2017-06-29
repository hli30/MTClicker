//
//  BuildingDetailsViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit
import RealmSwift

class BuildingDetailsViewController: UIViewController {

    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var buildingImageView: UIImageView!
    @IBOutlet weak var currentDetailsTextView: UITextView!
    @IBOutlet weak var nextDetailsTextView: UITextView!
    
    var player:Player?
    var building:Buildings?
    let outputFormatter = OutPutFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadView()
        
    }
    
    @IBAction func upgradeButtonPressed(_ sender: UIButton) {
        building?.level += 1
        progressBarView.setProgress(Float((building?.level)!), animated: true)
        let realm = try! Realm()
        
        try! realm.write {
            self.player?.properties.append(self.building!)
        }
        
        self.reloadView()
    }
    
    @IBAction func sellButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadView() {
        currentDetailsTextView.text = outputFormatter.buildingDetailsFormatter(building: building!)
        nextDetailsTextView.text = outputFormatter.nextLvlBuildingDetailsFormatter(building: building!)
//        buildingImageView.image = building?.iconImage
        progressBarView.progressViewStyle = .bar
        progressBarView.setProgress(Float((building?.level)!), animated: true)
    }
    
}
