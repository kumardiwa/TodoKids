//
//  DesigningConstant.swift
//  letstrack
//
//  Created by Diwakar Kumar on 16/06/17.
//  Copyright © 2017 Prima Business. All rights reserved.
//

import Foundation
import UIKit
import Foundation
class DKLabelDesigning{
    class var fontName : String{
        return "Corbel Regular"
    }
}
class DKTitleLabel: DKLabelDesigning {
    class var fontSize : CGFloat{
        return 17.0
    }
    class var textColor : UIColor{
       return UIColor().colorFromRGB(0x1b1b1b)//UIColor(netHex: 0x1b1b1b)
    }
}
class DKSubTitleLabel: DKLabelDesigning{
    class var fontSize : CGFloat{
        return 12.0
    }
    class var textColor : UIColor{
        return UIColor().colorFromRGB(0x1b1b1b)
    }
}
