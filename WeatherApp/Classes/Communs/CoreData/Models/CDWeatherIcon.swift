//
//  CDWeatherIcon.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import CoreData

class CDWeatherIcon: NSManagedObject, ManagedObjectType {
    static let entityName: String = "CDWeatherIcon";
    static let defaultSortDescriptors: [NSSortDescriptor] = []
    
    /**
     Map the coredata weather icon attributes with the weather icon struct attributes
     
     - parameter weatherIcon: The weatherIcon instance of class WeatherIcon
     - parameter cdWeather:   The weather object, instance of class CDWeather
     */
    func map(with weatherIcon: WeatherIcon, cdWeather: CDWeather) {
        icon = weatherIcon.icon
        weather = cdWeather
    }
}


