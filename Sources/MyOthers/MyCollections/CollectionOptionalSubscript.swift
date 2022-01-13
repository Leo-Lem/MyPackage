//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

//MARK: returns an optional value instead of failing when index is out of range
extension Collection where Indices.Iterator.Element == Index {
    public subscript(optional index: Index) -> Iterator.Element? {
        (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

//MARK: methods for removing duplicates from array
extension Array where Element: Equatable {
    public mutating func removeDuplicates() {
        self = self.byRemovingDuplicates()
    }
    
    public func byRemovingDuplicates() -> Self {
        var array = self
        
        array = array.reduce([]) { items, nextItem in
            !items.contains(nextItem) ? items + [nextItem] : items
        }
        
        return array
    }
}

//MARK: other methods
extension Array {
    public func drop(at index: Int) -> Self {
        var array = self
        array.remove(at: index)
        return array
    }
    
    public func byInserting(_ element: Element, at index: Int) -> Self {
        var array = self
        array.insert(element, at: index)
        return array
    }
}
