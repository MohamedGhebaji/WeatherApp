//
//  CDWeatherIcon+CoreDataProperties.swift
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

extension CDWeatherIcon {

    @NSManaged var icon: String?
    @NSManaged var iconDescription: String?
    @NSManaged var weather: CDWeather?

}
