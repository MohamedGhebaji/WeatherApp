//
//  NSDateFormatter+Helpers.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
extension NSDateFormatter {
    /**
     Instantiate NSDateFormatter with format
     
     - parameter format: The date format
     
     - returns: Instande of NSDateFormatter
     */
    convenience init(format: String) {
        self.init()
        dateFormat = format
        timeZone = NSTimeZone.localTimeZone()
    }
}