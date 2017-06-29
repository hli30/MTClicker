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
    
    func calculateTapMultiplier(player:Player) -> Double {
        var multiplierSum:Double = 0
        
        for items in player.inventory {
            multiplierSum += items.incomeMultiplier
        }
        
        return multiplierSum
        
    }
    
    func getTapIncome(level:Double,player:Player) -> Double {
        let steepnessOfCurve = 1.50
        let baseIncome = level
        
        let multiplier = self.calculateTapMultiplier(player: player)
        
        let incomeGrowth = 1 - 1 / ((steepnessOfCurve)^^level)
        var tapIncome = baseIncome * (1.0 + incomeGrowth)
        
        let multiplierOnIncome = multiplier * tapIncome
        
        tapIncome = tapIncome + multiplierOnIncome
        
        round(tapIncome)
        return tapIncome
    }
    

    
}
