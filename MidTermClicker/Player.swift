//
//  Player.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit
import RealmSwift


class Player: Object {

    dynamic var money:Double = 0
    dynamic var avatar:Data!
    dynamic var prestige:Int = 0
    dynamic var settings:Settings!
    dynamic var name: String!
    dynamic var level:Int = 1;
    dynamic var levelCost:Double = 100
    let inventory = List<Items>()
    let properties = List<Buildings>()
    
    convenience init(playerName:String,playerAvatar:Data) {
        self.init()
        
        name = playerName
        avatar = playerAvatar
    }
    
}

