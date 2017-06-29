//
//  Items.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation
import UIKit

class Items: Upgrades {
        
    enum ItemTypes {
        case shovel
        case sickle
        case tractor
    }
    
    convenience init(type : ItemTypes) {
        self.init()
        
        switch type {
        case .shovel:
            makeShovel()
        case .sickle:
            makeSickle()
        case .tractor:
            makeTractor()
        }

    }
    
    func makeShovel() {
        name = ""
        upgradeDescription = "This is a shovel"
        incomeMultiplier = 0.10
        price = 50.0
        iconImage = UIImage.convertImageToData(imageName: "Shovel")
    }
    
    func makeSickle() {
        name = ""
        upgradeDescription = "This is a sickle"
        iconImage = UIImage.convertImageToData(imageName: "Sickle")
        incomeMultiplier = 0.20
        price = 200.0
    }
    
    func makeTractor() {
        name = ""
        upgradeDescription = "This is a tractor"
        iconImage = UIImage.convertImageToData(imageName: "Tractor")
        incomeMultiplier = 0.30
        price = 500.0
    }
    

}
