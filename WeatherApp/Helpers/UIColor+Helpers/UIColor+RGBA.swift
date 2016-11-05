//
//  UIColor+RGBA.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     Instantiate UIColor with red, green and blue value
     
     - parameter red:   The red value
     - parameter green: The green color value
     - parameter blue:  The blue color value
     
     - returns: Instance of UIColor
     */
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /**
     Instantiate UIColor with hex value
     
     - parameter hex: The hex integ
     
     - returns: Instance of UIColor
     */
    convenience init(hex: Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}