//
//  NSManagedObjectContext+Helpers.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    /**
     Insert new NSManagedObject with it's entity name, used to facilitate the create of the managed object
     
     - returns: The instantiated NSManagedObject
     */
    func insertObject<A:NSManagedObject where A:ManagedObjectType>() -> A {
        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A else {
            fatalError("Enity \(A.entityName) does not correspond to \(A.self)")
        }
        return obj
    }
}