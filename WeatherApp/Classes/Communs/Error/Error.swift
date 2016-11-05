//
//  Error.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
struct HTTPRequestError {
    enum Code: Int {
        case URLError                 = -400
        case NetworkRequestFailed     = -401
        case JSONSerializationFailed  = -402
    }
    
    let errorCode: Code
}