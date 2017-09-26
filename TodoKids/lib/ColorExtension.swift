//
//  ColorExtension.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 21/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    class var navigationBarColor : UIColor{
        //return self.init(red: 194/255, green: 223/255, blue: 162/255, alpha: 1.0)
        return UIColor().colorFromRGB(0x0091C7)
    }
    
    func colorFromRGB(_ rgbValue : Int) -> UIColor{
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
