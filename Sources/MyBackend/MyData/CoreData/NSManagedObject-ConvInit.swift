//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 04.01.22.
//

import CoreData

//MARK: makes initializing core data objects without a view context a bit simpler
extension NSManagedObject {
    public convenience init(context: NSManagedObjectContext?) {
        if let context = context {
            self.init(context: context)
        } else {
            self.init(entity: Self.entity(), insertInto: context)
        }
    }
}
