//
//  Upgrades.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-26.
//  Copyright © 2017 Harry. All rights reserved.
//

import RealmSwift

class Upgrades: Object {
    
    dynamic var name:String?
    dynamic var upgradeDescription:String?
    dynamic var incomeMultiplier:Double = 0
    dynamic var iconImage:Data?
    dynamic var price:Int = 0
    
    func convertImageToData(imageName:String) -> Data? {
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            return nil
        }
        
        return imageData
    }
    
    func convertDataToImage(dataToBeConverted:Data) -> UIImage? {
        guard let image = UIImage(data: dataToBeConverted) else {
            return nil
        }

        return image
    }
  
}

