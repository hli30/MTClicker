//
//  UIImageExtension.swift
//  MidTermClicker
//
//  Created by Jimmy Hoang on 2017-06-28.
//  Copyright © 2017 Harry. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func convertImageToData(imageName:String) -> Data? {
        
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            return nil
        }
        
        return imageData
    }
    
    class func convertDataToImage(dataToBeConverted:Data) -> UIImage? {
        guard let image = UIImage(data: dataToBeConverted) else {
            return nil
        }
        
        return image
    }
}
