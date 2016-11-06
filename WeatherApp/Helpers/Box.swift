//
//  Box.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
final class Box<A> {
    let unbox: A
    init(_ vaue: A) {
        unbox = vaue
    }
}