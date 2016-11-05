//
//  JSONDecodable.swift
//  WeatherApp
//
//  Created by Mohamed on 03/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation

typealias JSON = [String:AnyObject]

protocol JSONDecodable {
    init(json: JSON?) throws
}