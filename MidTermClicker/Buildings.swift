//
//  Buildings.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation
import UIKit
import Realm.RLMSchema

class Buildings: Upgrades {
    dynamic var passiveIncome:Double = 0
    
    convenience init(upgradeName:String, upgradeDescrip:String, upgradeIncMulti:Double, upgradeIcon:UIImage, upgradePassiveInc: Double) {
        self.init()
        name = upgradeName
        upgradeDescription = upgradeDescrip
        incomeMultiplier = upgradeIncMulti
        iconImage = upgradeIcon
        passiveIncome = upgradePassiveInc
    }
}
