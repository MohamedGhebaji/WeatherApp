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
    
    /**
     Instantiate the view model with the weather list
     
     - parameter weathers: The list of the weather returned from the API
     
     - returns: Instance of WeatherDaysListViewModel
     */
    init(weathers: [Weather], shoudlSave: Bool = true) {
        
        if shoudlSave {
            CDWeather.deleteAll()
            for weather in weathers {
                let cdWeather: CDWeather = backgroundContext.insertObject()
                cdWeather.map(with: weather)
                appDelegate.coreDataHelper.saveContextWithCompletion({ (error) in
                    if error != nil {
                        print("error when saving the weathers \(error)")
                    }
                })
            }
        }
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
    
    /**
     Convert the timestamp to user frindly text
     
     - parameter timeStamp: The timeStamp to convert
     
     - returns: String date format (Lundi,2sep.)
     */
    func stringFromTimeStamp(timeStamp: NSTimeInterval?) -> String? {
        let dateFormatter = NSDateFormatter(format: "EEEE, d MMM")
        guard let timeStamp = timeStamp else {
            return nil
        }
        let date = NSDate(timeIntervalSince1970: timeStamp)
        return dateFormatter.stringFromDate(date)
    }
    
    /**
     Filter the weather list to return the weathers with the same date passed in params
     
     - parameter date:     The date to use in the filter action
     - parameter weathers: The list of all weathers
     
     - returns: An array of weather
     */
    func weathersByDate(date: NSDate, fromWeathers weathers: [Weather]) -> [Weather] {
        return weathers.filter { (weather) -> Bool in
            let dateFormatter = NSDateFormatter(format: "MM/dd/yyyy")
            return dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: weather.dateTimeStamp!)) == dateFormatter.stringFromDate(date)
        }
    }
}