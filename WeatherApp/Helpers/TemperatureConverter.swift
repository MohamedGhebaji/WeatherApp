//
//  TemperatureConverter.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
struct TemperatureConverter {
    static func kelvinToCelsius(degrees: Double) -> Int {
        return Int(round(degrees - 273.15))
    }
}