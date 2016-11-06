
//
//  Weather.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation

struct Weather: JSONDecodable {
    
    let dateTimeStamp: NSTimeInterval?
    let temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let seaLevel: Double?
    let grndLevel: Double?
    let humidity: Double?
    let weatherIcon: WeatherIcon?
    let clouds: Int?
    let wind: Wind?
    let rain: Double?
    var weatherTime: String? {
        let dateFormatter = NSDateFormatter(format: "H:mm a")
        guard let dateTimeStamp = dateTimeStamp else {
            return nil
        }
        let date = NSDate(timeIntervalSince1970: dateTimeStamp)
        return dateFormatter.stringFromDate(date)
    }
    /**
     Instantiate Weather with the JSON type
     
     - parameter json: The JSON type
     
     - throws: Throw error in case of json passed is nil, or when mandotary arttribute is missiong
     
     - returns: Instance of Weather or nil in case of throw
     */
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONSerialisationError.JSONIsNil
        }
        dateTimeStamp = json["dt"] as? Double
        temp = (json["main"] as? JSON)?["temp"] as? Double
        tempMin = (json["main"] as? JSON)?["temp_min"] as? Double
        tempMax = (json["main"] as? JSON)?["temp_max"] as? Double
        pressure = (json["main"] as? JSON)?["pressure"] as? Double
        seaLevel = (json["main"] as? JSON)?["sea_level"] as? Double
        grndLevel = (json["main"] as? JSON)?["grnd_level"] as? Double
        humidity = (json["main"] as? JSON)?["humidity"] as? Double
        do {
            weatherIcon = try WeatherIcon(json: ((json["weather"] as? [JSON])?[0]))
        } catch {
            throw JSONSerialisationError.MissingParam("weatherIcon")
        }
        do {
            wind = try Wind(json: json["wind"] as? JSON)
        } catch {
            throw JSONSerialisationError.MissingParam("Wind")
        }
        clouds = (json["clouds"] as? JSON)?["all"] as? Int
        rain = (json["rain"] as? JSON)?["3h"] as? Double
    }
}

extension Weather {
    /**
     Instantiate the Weather struct from the weather core data object
     
     - parameter cdWeather: The core data weather instance
     
     - returns: Instance of Weather
     */
    init(cdWeather: CDWeather) {
        dateTimeStamp = cdWeather.dateTimeStamp
        temp = cdWeather.temp
        tempMin = cdWeather.tempMin
        tempMax = cdWeather.tempMax
        pressure = cdWeather.pressure
        seaLevel = cdWeather.seaLevel
        grndLevel = cdWeather.grndLevel
        humidity = cdWeather.humidity
        clouds = Int(cdWeather.clouds)
        rain = cdWeather.rain
        weatherIcon = WeatherIcon(cdWeatherIcon: cdWeather.weatherIcon)
        wind = Wind(cdWind: cdWeather.wind)
    }
}