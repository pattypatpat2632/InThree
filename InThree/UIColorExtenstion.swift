//
//  UIColorExtenstion.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import Foundation
import UIKit

extension UIColor {
    
    //Scheme 1 - Paint
    open class var ultraMarine: UIColor {
        return UIColor(displayP3Red: 6/255, green: 18/255, blue: 131/255, alpha: 1)
    }
    
    open class var watermelon: UIColor {
        return UIColor(displayP3Red: 253/255, green: 60/255, blue: 60/255, alpha: 1)
    }
    
    open class var sunshine: UIColor {
        return UIColor(displayP3Red: 1, green: 183/255, blue: 76/255, alpha: 1)
    }
    
    open class var turquoise: UIColor {
        return UIColor(displayP3Red: 19/255, green: 141/255, blue: 144/255, alpha: 1)
    }
    
    //Scheme 2 - Night
    open class var nightCyan: UIColor {
        return UIColor(displayP3Red: 0, green: 207/255, blue: 250/255, alpha: 1)
    }
    
    open class var nightMagenta: UIColor {
        return UIColor(displayP3Red: 1, green: 0, blue: 56/255, alpha: 1)
    }
    
    open class var nightYellow: UIColor {
        return UIColor(displayP3Red: 1, green: 206/255, blue: 56/255, alpha: 1)
    }
    
    open class var nightBlack: UIColor {
        return UIColor(displayP3Red: 2/255, green: 5/255, blue: 9/255, alpha: 1)
    }
    
    //Scheme 3 - Normal
    
    open class var night: UIColor {
        return UIColor(displayP3Red: 0, green: 11/255, blue: 41/255, alpha: 1)
    }
    
    open class var phoneBoothRed: UIColor {
        return UIColor(displayP3Red: 215/255, green: 0, blue: 38/255, alpha: 1)
    }
    
    open class var pearl: UIColor {
        return UIColor(displayP3Red: 248/255, green: 245/255, blue: 242/255, alpha: 1)
    }
    
    open class var flash: UIColor {
        return UIColor(displayP3Red: 237/255, green: 184/255, blue: 61/255, alpha: 1)
    }
    
    //Scheme 4 - Gameboy
    
    open class var darkestGreen: UIColor {
        return UIColor(displayP3Red: 15/255, green: 156/255, blue: 15/255, alpha: 1)
    }
    
    open class var darkGreen: UIColor {
        return UIColor(displayP3Red: 48/255, green: 98/255, blue: 48/255, alpha: 1)
    }
    
    open class var lightGreen: UIColor {
        return UIColor(displayP3Red: 1390/255, green: 172/255, blue: 15/255, alpha: 1)
    }
    
    open class var lightestGreen: UIColor {
        return UIColor(displayP3Red: 155/255, green: 188/255, blue: 15/255, alpha: 1)
    }
    
    //Scheme 5 - Vibrant
    
    open class var sky: UIColor {
        return UIColor(displayP3Red: 55/255, green: 94/255, blue: 151/255, alpha: 1)
    }
    
    open class var sunset: UIColor {
        return UIColor(displayP3Red: 251/255, green: 101/255, blue: 66/255, alpha: 1)
    }
    
    open class var sunflower: UIColor {
        return UIColor(displayP3Red: 1, green: 187/255, blue: 0, alpha: 1)
    }
    
    open class var grass: UIColor {
        return UIColor(displayP3Red: 63/255, green: 104/255, blue: 28/255, alpha: 1)
    }
    
    
    
    //MARK: Random color generator
    open class var randomColor: UIColor {
        let red = drand48()
        let green = drand48()
        let blue = drand48()
        return UIColor(displayP3Red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
    
    
}
