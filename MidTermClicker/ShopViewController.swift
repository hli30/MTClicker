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
    var player:Player?
    var itemShop:[Items] = []
    
    override func viewDidLoad() {
        let shovel = Items.init(type: .shovel)
        let sickle = Items.init(type: .sickle)
        let tractor = Items.init(type: .tractor)
        self.itemShop = [shovel, sickle, tractor]

    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShopViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCell", for: indexPath) as! ShopCell
        let item = self.itemShop[indexPath.row]
        
        if (player?.inventory.contains(item))! {
            cell.tintColor = UIColor.gray
        }
        
        cell.itemDescriptionTextView.text = item.upgradeDescription
        cell.itemImageView.image = item.iconImage
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemShop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController.init(title: "Purchase Confirmation",
                                                   message: "\(self.itemShop[indexPath.row].price) will be deducted",
                                            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if (player?.money)! > self.itemShop[indexPath.row].price {
            alertController.addAction(UIAlertAction.init(title: "Confirm",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(alertController:UIAlertAction) in
                                                            
                                                            let realm = try! Realm()
                                                            
                                                            try! realm.write {
                                                                self.player?.inventory.append(self.itemShop[indexPath.row])
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
