//
//  CDWind.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import CoreData

class CDWind: NSManagedObject, ManagedObjectType {
    static let entityName: String = "CDWind";
    static let defaultSortDescriptors: [NSSortDescriptor] = []

    /**
     Map the wind core data attribute with the wind struct attributes
     
     - parameter wind:      The wind struct instance
     - parameter cdWeather: The weather core data instance
     */
    func map(with wind: Wind, cdWeather: CDWeather) {
        speed = wind.speed ?? 0
        deg = wind.deg ?? 0
        weather = cdWeather
    }
}
