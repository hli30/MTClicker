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
    
    convenience init(upgradeName:String, upgradeDescrip:String, upgradeIncMulti:Double, upgradeIcon:UIImage) {
        self.init()
        name = upgradeName
        upgradeDescription = upgradeDescrip
        incomeMultiplier = upgradeIncMulti
        iconImage = upgradeIcon
    }
}
