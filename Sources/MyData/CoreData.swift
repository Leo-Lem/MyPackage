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
    associatedtype CD: NSManagedObject
    
    /// The CoreData (CD)Object to represent.
    var cd: CD { get }
    
    /// Intializes a CDRepresentable with a given CoreData (CD)Object.
    /// - Parameter cd: The CDObject to represent.
    init(_ cd: CD)
    
}

public extension CDRepresentable {
    
    init?(_ cd: CD?) {
        if let cd = cd { self.init(cd) } else { return nil }
    }
    
    func willChange() { cd.objectWillChange.send() }
    
    var id: NSManagedObjectID { self.cd.objectID }
    var idString: String { self.cd.objectID.uriRepresentation().absoluteString }
    
}
