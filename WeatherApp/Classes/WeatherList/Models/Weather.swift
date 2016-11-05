
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