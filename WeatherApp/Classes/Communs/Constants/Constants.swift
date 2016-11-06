//
//  Constants.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct API {
        static let baseURL = "http://api.openweathermap.org/data/2.5/forecast"
        static let iconBaseURL = "http://openweathermap.org/img/w/"
        static let openWeatherMapAPIKey = "cbfc9ceb3c7ce093c63eb96f0170be7b"
        static let parisCityId = "6455259"
    }
}

let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
let backgroundContext = appDelegate.coreDataHelper.backgroundContext!
let mainQueuContext = appDelegate.coreDataHelper.managedObjectContext