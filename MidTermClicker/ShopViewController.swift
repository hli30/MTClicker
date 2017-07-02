//
//  ShopViewController.swift
//  MidTermClicker
//
//  Created by Jimmy Hoang on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ShopViewController:UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var player:Player!
    var itemShop:[Items] = [Items(type: .shovel),
                            Items(type: .sickle),
                            Items(type: .tractor)]
    
    override func viewDidLoad() {

    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension ShopViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCell", for: indexPath) as! ShopCell
        let item = itemShop[indexPath.item]
        
        cell.itemDescriptionTextField.text = item.upgradeDescription
        
        guard let image = UIImage.convertDataToImage(dataToBeConverted: item.iconImage) else {
            print("cell image not valid")
            return cell
        }
        
        cell.itemImageView.image = image
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemShop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController.init(title: "Purchase Confirmation",
                                                   message: "$\(itemShop[indexPath.item].price)0 will be deducted",
                                            preferredStyle: UIAlertControllerStyle.alert)
        
        if player.money >= itemShop[indexPath.item].price {
            alertController.addAction(UIAlertAction.init(title: "Confirm",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(alertController:UIAlertAction) in
                                                            
                                                            let realm = try! Realm()
                                                            
                                                            let newMoney = self.player.money - self.itemShop[indexPath.item].price
                                                            
                                                            try! realm.write {
                                                                self.player.money = newMoney
                                                                self.player.inventory.append(self.itemShop[indexPath.row])
                                                            }
                                                      
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
        
        present(alertController, animated: true, completion: nil)
    }
}
