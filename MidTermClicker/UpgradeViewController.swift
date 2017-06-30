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

protocol UpgradeVCDelegate: class
{
    func updateNode(with image: UIImage)
}

class UpgradeViewController:UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: UpgradeVCDelegate?
    var player:Player!
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
        let building = self.buildingShop[indexPath.item]
        
        cell.buildingDescriptionTextField.text = building.upgradeDescription
        
        guard let image = UIImage.convertDataToImage(dataToBeConverted: building.iconImage) else {
            return cell
        }
        
        cell.buildingImageView.image = image
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.buildingShop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("user pressed")
        let alertController = UIAlertController.init(title: "Purchase Confirmation",
                                                     message: "\(self.buildingShop[indexPath.item].price)0 will be deducted",
            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if self.player.money >= self.buildingShop[indexPath.item].price {
            alertController.addAction(UIAlertAction.init(title: "Confirm",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(alertController:UIAlertAction) in
                                                            
                                                            let realm = try! Realm()
                                                            
                                                            let newMoney = self.player.money - self.buildingShop[indexPath.item].price
                                                            try! realm.write {
                                                                self.player.money = newMoney
                                                                self.player.properties.append(self.buildingShop[indexPath.row])
                                                            }
                                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewControlledClosed"), object: nil)
                                                            
                                                            let buildingToBePassed:[String:Buildings] = ["building":self.buildingShop[indexPath.item]]
                                                            
                                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"purchasedProperty"), object: nil, userInfo: buildingToBePassed)
                                                            
                                                            guard let imageData = self.buildingShop[indexPath.item].iconImage else { return }
                                                            guard let buildingImage = UIImage.convertDataToImage(dataToBeConverted: imageData) else { return }
                                                            self.delegate?.updateNode(with: buildingImage)
                                                            
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
}
