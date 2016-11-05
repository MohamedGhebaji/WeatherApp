//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
struct WeatherIcon: JSONDecodable {
    let icon: String?
    
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONSerialisationError.JSONIsNil
        }
        icon = json["icon"] as? String
    }
}

extension WeatherIcon {
    init?(cdWeatherIcon: CDWeatherIcon?) {
        guard let cdWeatherIcon = cdWeatherIcon else {
            return nil
        }
        icon = cdWeatherIcon.icon
    }
}