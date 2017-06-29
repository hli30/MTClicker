//
//  OutPutFormatter.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation

class OutPutFormatter {
    
    init() {
        
    }
    
    func buildingDetailsFormatter(building:Buildings) -> String {
        let name = building.name
        let buildingDescription = building.upgradeDescription
        let buildingPassiveIncome = "Passive income: \(building.passiveIncome)"
        
        let outputString = "\(String(describing: name))\n\(String(describing: buildingDescription))\n\(buildingPassiveIncome)"
        
        return outputString
    }
    
    func nextLvlBuildingDetailsFormatter(building:Buildings) -> String {
        let name = building.name
        let buildingDescription = building.upgradeDescription
        let nextLvlPassiveIncome = building.passiveIncome * 2
        let buildingPassiveIncome = "Passive income: \(nextLvlPassiveIncome)"
        
        let outputString = "\(String(describing: name))\n\(String(describing: buildingDescription))\n\(buildingPassiveIncome)"
        
        return outputString
    }
    
    func itemDetailsFormatter(item:Items) -> String {
        let name = item.name!
        let itemDescription = item.upgradeDescription!
        let itemMultiplier = "Income multiplier: \(item.incomeMultiplier)"
        
        let outputString = "\(String(describing: name))\n\(String(describing: itemDescription))\n\(itemMultiplier)"
        
        return outputString
    }
    
}
