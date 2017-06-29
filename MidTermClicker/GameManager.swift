//
//  GameManager.swift
//  MidTermClicker
//
//  Created by Jimmy Hoang on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation


class GameManager {
    
    func calculatePassiveIncome(player:Player){
        var passive:Double = 0
        
        for building in player.properties {
            passive += building.getPassiveIncome()
        }
        
    }
    
    func calculateTapMultiplier(player:Player) {
        var multiplierSum:Double = 0
        
        for items in player.inventory {
            multiplierSum += items.incomeMultiplier
        }
        
    }
    
    func getTapIncome(level:Double) -> Int {
        let steepnessOfCurve = 1.50
        let baseIncome = level
        
        let incomeGrowth = 1 - 1 / ((steepnessOfCurve)^^level)
        let tapIncome = baseIncome * (1.0 + incomeGrowth)
        
        return Int(tapIncome)
    }
    

    
}
