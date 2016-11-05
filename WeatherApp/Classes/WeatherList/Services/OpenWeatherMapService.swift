//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

typealias RetrieveWeatherCompletionHandler = (([Weather], HTTPRequestError?) -> Void)

struct OpenWeatherMapService {
    func retrieveWeatherInfo(inCity city: String, withCompletion completionHandler: RetrieveWeatherCompletionHandler) {
        Alamofire.request(.GET, Constants.API.baseURL, parameters: ["id":city,"appid":Constants.API.openWeatherMapAPIKey], encoding: .URL).responseJSON { (response) in
            guard response.result.isSuccess else {
                return completionHandler([], HTTPRequestError(errorCode: .NetworkRequestFailed))
            }
            guard let json = response.result.value as? [String:AnyObject],let list = json["list"] as? [JSON] else {
                return completionHandler([], HTTPRequestError(errorCode: .JSONSerializationFailed))
            }
            var weathers = [Weather]()
            for JSON in list {
                do {
                    weathers.append(try Weather(json: JSON))
                } catch let error as JSONSerialisationError {
                    print("error : \(error.description)")
                    return completionHandler([], HTTPRequestError(errorCode: .JSONSerializationFailed))
                } catch {
                    print("Unkwon error")
                    return completionHandler([], HTTPRequestError(errorCode: .JSONSerializationFailed))
                }
            }
            completionHandler(weathers, HTTPRequestError(errorCode: .JSONSerializationFailed))
        }
    }
}