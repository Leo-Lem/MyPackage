//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

//MARK: - Array
//TODO: add documentation
public extension Array {
    
    /***/
    mutating func prepend(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    /***/
    mutating func removeDuplicates() where Element: Equatable {
        self = self.reduce([]) { items, nextItem in
            !items.contains(nextItem) ? items + [nextItem] : items
        }
    }
    
}
