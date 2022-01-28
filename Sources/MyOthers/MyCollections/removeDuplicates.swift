//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 25.01.22.
//

import Foundation

//MARK: methods for removing duplicates from array
public extension Array where Element: Equatable {
    mutating func removeDuplicates() { self = self.byRemovingDuplicates() }
    
    func byRemovingDuplicates() -> Self {
        var array = self
        
        array = array.reduce([]) { items, nextItem in
            !items.contains(nextItem) ? items + [nextItem] : items
        }
        
        return array
    }
}
