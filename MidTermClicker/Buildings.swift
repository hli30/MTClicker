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
    dynamic var level:Double = 1;
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
        iconImage = UIImage.convertImageToData(imageName: "Farm")
        passiveIncome = 100
        price = basePrice * (costMultiplier ^^ level)
    }
    
    func makeGarden() {
        let basePrice:Double = 500
        name = "Garden"
        upgradeDescription = "This is a garden"
        iconImage = UIImage.convertImageToData(imageName: "Garden")
        passiveIncome = 200
        price = basePrice * (costMultiplier ^^ level)
    }
    
    func makeChickenCoop() {
        let basePrice:Double = 500
        name = "Chicken Coop"
        upgradeDescription = "This is a chicken coop"
        iconImage = UIImage.convertImageToData(imageName: "Chickencoop")
        passiveIncome = 300
        price = basePrice * (costMultiplier ^^ level)
    }
    
    func getPassiveIncome() -> Double {
        return self.passiveIncome * self.level * 0.25
    }
    
}
