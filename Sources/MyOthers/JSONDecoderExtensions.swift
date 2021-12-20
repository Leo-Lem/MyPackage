//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
    
    convenience init(context: NSManagedObjectContext , dateFormat: String) {
        self.init(context: context)
        self.dateDecodingStrategy = .formatted(DateFormatter(withDateFormat: dateFormat))
    }
}
