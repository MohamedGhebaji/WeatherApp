//
//  ManagedObjectType.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectType {
    static var entityName: String {get}
    static var defaultSortDescriptors: [NSSortDescriptor] {get}
}

extension ManagedObjectType {
    static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}