//
//  Upgrades.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import RealmSwift

class Upgrades: Object {
    
    dynamic var name:String!
    dynamic var upgradeDescription:String!
    dynamic var incomeMultiplier:Double = 0
    dynamic var iconImage:Data!
    dynamic var price:Double = 0
}

