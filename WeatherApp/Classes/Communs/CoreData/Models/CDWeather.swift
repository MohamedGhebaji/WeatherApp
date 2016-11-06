//
//  CDWeather.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import CoreData

class CDWeather: NSManagedObject, ManagedObjectType {
    
    static let entityName: String = "CDWeather";
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "dateTimeStamp", ascending: true)]
    }
    
    /**
     Map the weather core data attributes with the weather struct attributes
     
     - parameter weather: The weather struct instance
     */
    func map(with weather: Weather) {
        dateTimeStamp = weather.dateTimeStamp ?? 0
        temp = weather.temp ?? 0
        tempMin = weather.tempMin ?? 0
        tempMax = weather.tempMax ?? 0
        pressure = weather.pressure ?? 0
        seaLevel = weather.seaLevel ?? 0
        grndLevel = weather.grndLevel ?? 0
        humidity = weather.humidity ?? 0
        clouds = Int16(weather.clouds ?? 0)
        rain = weather.rain ?? 0
        if let weatherIcon = weather.weatherIcon {
            let cdWeatherIcon: CDWeatherIcon = backgroundContext.insertObject()
            cdWeatherIcon.map(with: weatherIcon, cdWeather: self)
            self.weatherIcon = cdWeatherIcon
        }
        if let wind = weather.wind {
            let cdWind: CDWind = backgroundContext.insertObject()
            cdWind.map(with: wind, cdWeather: self)
            self.wind = cdWind
        }
    }
    
    /**
     Static method, used to delete all the saved weathers
     */
    static func deleteAll() {
        do {
            let savedWeathers = try backgroundContext.executeFetchRequest(CDWeather.sortedFetchRequest) as! [CDWeather]
            for weather in savedWeathers {
                backgroundContext.deleteObject(weather)
            }
        } catch let error as NSError{
            print("enable to delete weather objects \(error))")
        }
    }
    
    static func findAll() -> [CDWeather] {
        do {
            return try backgroundContext.executeFetchRequest(CDWeather.sortedFetchRequest) as! [CDWeather]
        } catch let error as NSError {
            print("enable to find weather objects \(error))")
            return []
        }
    }
}
