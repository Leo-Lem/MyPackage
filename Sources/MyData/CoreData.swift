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

//MARK: - (CD Representable)

/// A Swift Object which represents a CoreData object and optionally bridges it's properties/methods etc.
public protocol CDRepresentable {
    
    /// The Type of the associated CoreData (CD)Object
    associatedtype CDObject: NSManagedObject
    
    /// The CoreData (CD)Object to represent.
    var cd: CDObject { get }
    
    /// Intializes a CDRepresentable with a given CoreData (CD)Object.
    /// - Parameter cd: The CDObject to represent.
    init(_ cd: CDObject)
    
}
