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

infix operator ^^
public func ^^ (radix: Double, power: Double) -> Double {
    return pow((radix), (power))
}


class Buildings: Upgrades {
    
    dynamic var passiveIncome:Double = 0
    dynamic var level:Double = 0;
    let costMultiplier = 1.10
    
    
    
    enum BuildingTypes {
        case garden,farm,chickenCoop
    }

    convenience init(type : BuildingTypes) {
        self.init()
        
        switch type {
        case .farm:
            makeFarm()
        case .garden:
            makeGarden()
        case .chickenCoop:
            makeChickenCoop()
        }
    }
    
    func makeFarm(){
        let basePrice:Double = 500
        name = "Farm"
        upgradeDescription = "This is a farm"
        iconImage = nil
        passiveIncome = 100
        price = Int(basePrice * (costMultiplier ^^ level))
        level = 1
    }
    
    func makeGarden() {
        let basePrice:Double = 500
        name = "Garden"
        upgradeDescription = "This is a garden"
        iconImage = nil
        passiveIncome = 200
        price = Int(basePrice * (costMultiplier ^^ level))
        level = 1
    }
    
    func makeChickenCoop() {
        let basePrice:Double = 500
        name = "Chicken Coop"
        upgradeDescription = "This is a chicken coop"
        iconImage = nil
        passiveIncome = 300
        price = Int(basePrice * (costMultiplier ^^ level))
        level = 1
    }
    
}
