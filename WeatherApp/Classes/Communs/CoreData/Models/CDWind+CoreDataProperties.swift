//
//  CDWind+CoreDataProperties.swift
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

extension CDWind {

    @NSManaged var speed: Double
    @NSManaged var deg: Double
    @NSManaged var weather: CDWeather?

}
