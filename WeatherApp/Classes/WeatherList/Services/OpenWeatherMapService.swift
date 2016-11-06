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
        //use Alamofire to send the GET request, with the city id and the appid as params encoded in the URL
        Alamofire.request(.GET, Constants.API.baseURL, parameters: ["id":city,"appid":Constants.API.openWeatherMapAPIKey], encoding: .URL).responseJSON { (response) in
            //get the response from the API
            //check if the ws call finish with success
            guard response.result.isSuccess else {
                //if no luck, return the completion block with empty list and error object
                return completionHandler([], HTTPRequestError(errorCode: .NetworkRequestFailed))
            }
            //check if the result returned is of type JSON(typalias of [String:AnyObject]) and it contains the list Array of type
            guard let json = response.result.value as? JSON,let list = json["list"] as? [JSON] else {
                //if no luck, return the empty list with the error object
                return completionHandler([], HTTPRequestError(errorCode: .JSONSerializationFailed))
            }
            //if all condition are ok
            //we start the parsing of the result
            var weathers = [Weather]()
            for JSON in list {
                do {
                    //instantiate the Weather struc twith JSON type
                    //if try is ok (no catch), it will be added to the list of weathers
                    weathers.append(try Weather(json: JSON))
                } catch let error as JSONSerialisationError {
                    //if catch exception raised
                    //log the problem
                    print("error : \(error.description)")
                    //return the completion block with empty list and error object
                    return completionHandler([], HTTPRequestError(errorCode: .JSONSerializationFailed))
                } catch {
                    //unknown catch exception, it will be treated as error
                    print("Unkwon error")
                    return completionHandler([], HTTPRequestError(errorCode: .JSONSerializationFailed))
                }
            }
            //finaly, no error, much of luck
            //fire the completion block with the weather list and nil error 
            completionHandler(weathers, nil)
        }
    }
}