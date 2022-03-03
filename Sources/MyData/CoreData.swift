//
//  CoreData.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 08.01.22.
//

import CoreData

public extension NSManagedObject {
    
    /***/
    func fetch(from context: NSManagedObjectContext) -> Self {
        guard let contextObject = context.object(with: self.objectID) as? Self else {
            context.insert(self)
            return self
        }
        
        return contextObject
    }
    
}

public extension CodingUserInfoKey {
    
    ///
    static let context = CodingUserInfoKey(rawValue: "context")!
    
}

public extension JSONDecoder {
    
    /***/
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
    
}
