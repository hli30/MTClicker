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

    dynamic var money:Int = 0
    dynamic var avatar:UIImage?
    dynamic var prestige:Int = 0
    dynamic var settings:Settings?
    dynamic var name: String?
    dynamic var level:Int = 1;
    let inventory = List<Items>()
    let properties = List<Buildings>()
    
    
    
}

