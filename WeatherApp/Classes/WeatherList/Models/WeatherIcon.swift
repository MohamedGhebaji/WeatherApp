//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation

public struct WeatherIcon: JSONDecodable {

    let icon: String?
    let iconDescription: String?
    
    /**
     Instantiate WeatherIcon with the JSON type
     
     - parameter json: The json type
     
     - throws: Throws erro when the json is nil
     
     - returns: Instance of WeatherIcon or nil
     */
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONSerialisationError.JSONIsNil
        }
        icon = json["icon"] as? String
        iconDescription = json["description"] as? String
    }
}

extension WeatherIcon {
    /**
     Instantiate WeatherIcon struct withe core data weather icon
     
     - parameter cdWeatherIcon: The core data weather icon
     
     - returns: Instance of WeatherIcon of nil
     */
    init?(cdWeatherIcon: CDWeatherIcon?) {
        guard let cdWeatherIcon = cdWeatherIcon else {
            return nil
        }
        icon = cdWeatherIcon.icon
        iconDescription = cdWeatherIcon.iconDescription
    }
}
