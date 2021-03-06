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
    private(set) var daysWeatherList = [[Weather]]()
    
    /**
     Instantiate the view model with the weather list
     
     - parameter weathers: The list of the weather returned from the API
     
     - returns: Instance of WeatherDaysListViewModel
     */
    init(weathers: [Weather], shoudlSave: Bool = true) {
        //if should save is true, delete all the saved objects, and save the new weather object, do nothing if the should save = false
        //we need to save when app is connected ==> shouldSave = true
        //we need to not resave the data when app is offline ==> shouldSave = false
        if shoudlSave {
            //delete all the saved weather objects
            CDWeather.deleteAll()
            //loop on the weathers objects and save it to core data
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
        //get the first day weathers
        let firstDayWeathers = weathersByDate(NSDate(), fromWeathers: weathers)
        if firstDayWeathers.count > 0 {
            //add it to the global weathers list
            daysWeatherList.append(firstDayWeathers)
        }
        //get the second day weathers
        let secondDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day), fromWeathers: weathers)
        if secondDayWeathers.count > 0 {
            //add it to the global weather list
            daysWeatherList.append(secondDayWeathers)
        }
        //get the third day weathers
        let thirdDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day*2), fromWeathers: weathers)
        if thirdDayWeathers.count > 0 {
            //add it to the global weather list
            daysWeatherList.append(thirdDayWeathers)
        }
        //get the fourth day weathers
        let fourthDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day*3), fromWeathers: weathers)
        if fourthDayWeathers.count > 0 {
            //add it to the global weather list
            daysWeatherList.append(fourthDayWeathers)
        }
        //get the five day weathers
        let fiveDayWeathers = weathersByDate(NSDate().dateByAddingTimeInterval(day*4), fromWeathers: weathers)
        if fiveDayWeathers.count > 0 {
            //add it to the global weather list
            daysWeatherList.append(fiveDayWeathers)
        }
        //loop on the weathers list, and get create the user frindly date to show in the tabbar items
        for weather in daysWeatherList {
            tabbarItems.append(stringFromTimeStamp(weather[0].dateTimeStamp))
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