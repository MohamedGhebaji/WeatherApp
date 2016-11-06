//
//  Wind.swift
//  WeatherApp
//
//  Created by Mohamed on 04/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
struct Wind: JSONDecodable {
    let speed: Double?
    let deg: Double?
    
    /**
     Instantiate Wind with the json type
     
     - parameter json: The json object
     
     - throws: Throw error when the json is nil
     
     - returns: Instance of Wind or nil
     */
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONSerialisationError.JSONIsNil
        }
        speed = json["speed"] as? Double
        deg = json["deg"] as? Double
    }
}

extension Wind {
    /**
     Instantiate Wind struct with the wind core data
     
     - parameter cdWind: The wind core data object
     
     - returns: Instance of Wind or nil
     */
    init?(cdWind: CDWind?) {
        guard let cdWind = cdWind else {
            return nil
        }
        speed = cdWind.speed
        deg = cdWind.deg
    }
}