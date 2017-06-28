//
//  OutPutFormatter.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation

class OutPutFormatter {
    
    func buildingDetailsFormatter(building:Buildings) -> String {
        var name = building.name
        var buildingDescription = building.upgradeDescription
        var buildingPassiveIncome = "Passive income: \(building.passiveIncome)"
        
        var outputString = "\(name)\n\(buildingDescription)\n\(buildingPassiveIncome)"
        
    }
    
    func itemDetailsFormatter(item:Items) -> String {
        var name = item.name
        var itemDescription = item.upgradeDescription
        var itemMultiplier = "Income multiplier: \(itemMultiplier)"
        
        var outputString = "\(name)\n\(itemDescription)\n\(itemMultiplier)"
        
        return outputString
    }
}
