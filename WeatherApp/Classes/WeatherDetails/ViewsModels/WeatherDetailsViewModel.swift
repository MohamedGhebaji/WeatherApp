//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
struct WeatherDetailsViewModel {
    
    private(set) var weatherIconURL: NSURL?
    private(set) var weatherDescription: String?
    private(set) var weatherTime: String?
    private(set) var temp: String?
    private(set) var humidity: String?
    private(set) var tempMax: String?
    private(set) var tempMin: String?
    private(set) var pression: String?
    private(set) var seaLevel: String?
    private(set) var wind: String?
    
    /**
     Instantiate WeatherDetailsViewModel with the weather object
     
     - parameter weather: The weather object
     
     - returns: Instance of WeatherDetailsViewModel
     */
    init(weather: Weather) {
        if let icon = weather.weatherIcon?.icon, let url = NSURL(string: Constants.API.iconBaseURL+icon+".png") {
            weatherIconURL = url
        }
        weatherDescription = weather.weatherIcon?.iconDescription
        temp = "\(TemperatureConverter.kelvinToCelsius(weather.temp ?? 0))\u{00B0}"
        weatherTime = weather.weatherTime
        humidity = "Humidité \(weather.humidity ?? 0)%"
        tempMax = "\(TemperatureConverter.kelvinToCelsius(weather.tempMax ?? 0))\u{00B0}"
        tempMin = "\(TemperatureConverter.kelvinToCelsius(weather.tempMin ?? 0))\u{00B0}"
        pression = "\(weather.pressure ?? 0)"
        seaLevel = "\((weather.seaLevel ?? 0)/1000)"
        wind = "\(weather.wind?.speed ?? 0)km/h"
    }
}