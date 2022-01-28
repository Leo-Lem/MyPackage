//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import CoreData

public extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

public extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
