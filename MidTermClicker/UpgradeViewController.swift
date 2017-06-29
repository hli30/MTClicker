//
//  UpgradeViewController.swift
//  MidTermClicker
//
//  Created by Jimmy Hoang on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class UpgradeViewController:UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var player:Player?
    var buildingShop:[Buildings] = [Buildings(type: .farm),
                                    Buildings(type: .garden),
                                    Buildings(type: .chickenCoop)]
    
    override func viewDidLoad() {

        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UpgradeViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buildingUpgradeCell", for: indexPath) as! UpgradeCell
        let building = self.buildingShop[indexPath.row]
        
        if (player?.properties.contains(building))! {
            cell.tintColor = UIColor.gray
        }
        
        cell.buildingDescriptionTextField.text = building.upgradeDescription
//        cell.buildingImageView.image = building.iconImage
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.buildingShop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController.init(title: "Purchase Confirmation",
                                                     message: "\(self.buildingShop[indexPath.row].price) will be deducted",
            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if (player?.money)! > self.buildingShop[indexPath.row].price {
            alertController.addAction(UIAlertAction.init(title: "Confirm",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(alertController:UIAlertAction) in
                                                            
                                                            let realm = try! Realm()
                                                            
                                                            try! realm.write {
                                                                self.player?.properties.append(self.buildingShop[indexPath.row])
                                                            }
                                                            
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
        
        
    }
}
