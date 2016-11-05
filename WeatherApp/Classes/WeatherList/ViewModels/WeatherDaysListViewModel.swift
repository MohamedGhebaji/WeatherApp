//
//  WeatherDaysListViewModel.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation

struct WeatherDaysListViewModel {
    
    private let day: NSTimeInterval = 60*60*24
    private(set) var tabbarItems = [String?]()
    private(set) var daysWeatherList = [Weather]()
    
    init(weathers: [Weather]) {
        let firstDayWeathers = weathersByDate(NSDate(), fromWeathers: weathers)
        if firstDayWeathers.count > 0 {
            daysWeatherList.append(firstDayWeathers[0])
        }
        let secondDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day), fromWeathers: weathers)
        if secondDayWeathers.count > 0 {
            daysWeatherList.append(secondDayWeathers[0])
        }
        let thirdDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day*2), fromWeathers: weathers)
        if thirdDayWeathers.count > 0 {
            daysWeatherList.append(thirdDayWeathers[0])
        }
        let fourthDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day*3), fromWeathers: weathers)
        if fourthDayWeathers.count > 0 {
            daysWeatherList.append(fourthDayWeathers[0])
        }
        let fiveDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day*4), fromWeathers: weathers)
        if fiveDayWeathers.count > 0 {
            daysWeatherList.append(fiveDayWeathers[0])
        }
        for weather in daysWeatherList {
            tabbarItems.append(stringFromTimeStamp(weather.dateTimeStamp))
        }
    }
}

private extension WeatherDaysListViewModel {
    func stringFromTimeStamp(timeStamp: NSTimeInterval?) -> String? {
        let dateFormatter = NSDateFormatter(format: "EEEE, d MMM")
        guard let timeStamp = timeStamp else {
            return nil
        }
        let date = NSDate(timeIntervalSince1970: timeStamp)
        return dateFormatter.stringFromDate(date)
    }
    
    func weathersByDate(date: NSDate, fromWeathers weathers: [Weather]) -> [Weather] {
        return weathers.filter { (weather) -> Bool in
            let dateFormatter = NSDateFormatter(format: "MM/dd/yyyy")
            return dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: weather.dateTimeStamp!)) == dateFormatter.stringFromDate(date)
        }
    }
}