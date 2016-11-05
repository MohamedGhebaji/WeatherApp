//
//  CDWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CDWeather {

    @NSManaged var dateTimeStamp: Double
    @NSManaged var temp: Double
    @NSManaged var tempMin: Double
    @NSManaged var tempMax: Double
    @NSManaged var pressure: Double
    @NSManaged var seaLevel: Double
    @NSManaged var grndLevel: Double
    @NSManaged var humidity: Double
    @NSManaged var clouds: Int16
    @NSManaged var rain: Double
    @NSManaged var weatherIcon: CDWeatherIcon?
    @NSManaged var wind: CDWind?

}
