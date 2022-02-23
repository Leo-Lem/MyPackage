//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

public extension Array {
    
    //TODO: add documentation
    /// Applying a transformation and returning the result without modifying the array itself.
    func applying(_ transformation: (inout Self) throws -> Void) rethrows -> Self {
        var array = self
        try transformation(&array)
        return array
    }
    
    //MARK: custom methods
    /// Non-mutating variant of `removeDuplicates()`.
    func removingDuplicates() -> Self where Element: Equatable {
        self.applying {
            $0.removeDuplicates()
        }
    }
    
    /// Non-mutating variant `prepend()`.
    func prepending(_ newElement: Element) -> Self {
        self.applying {
            $0.prepend(newElement)
        }
    }
    
    //MARK: built-in methods
    /// Non-mutating variant of Array's `append()`.
    func appending(_ newElement: Element) -> Self {
        self.applying {
            $0.append(newElement)
        }
    }
    
    /// Non-mutating variant of Array's `remove(at)`.
    func removing(at index: Int) -> Self {
        self.applying {
            $0.remove(at: index)
        }
    }
    
    /// Non-mutating variant of Array's `insert(_, at)`.
    func inserting(_ element: Element, at index: Int) -> Self {
        self.applying {
            $0.insert(element, at: index)
        }
    }
    
    /// Non-mutating variant of Array's `removeAll(where)`.
    func removingAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows -> Self {
        try self.applying {
            try $0.removeAll(where: shouldBeRemoved)
        }
    }
    
}
