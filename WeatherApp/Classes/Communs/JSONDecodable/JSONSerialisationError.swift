//
//  JSONSerialisationError.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation

enum JSONSerialisationError: ErrorType {
    case JSONIsNil
    case MissingParam(String)
}

extension JSONSerialisationError: CustomStringConvertible {
    var description: String {
        switch self {
        case .JSONIsNil: return "json passed is nil"
        case .MissingParam(let param): return "mission param : \(param)"
        }
    }
}