//
//  methods.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation

//MARK: - conversion to non-mutating and mutating methods respectively
public extension Sequence {
    
    /**
     Applies a transformation and returns the result without modifying the array itself.
     
     - parameter transformation: A closure taking the array as parameter yielding a transformed array.
     */
    @inlinable
    mutating func apply(_ transformation: (Self) throws -> Self) rethrows {
        self = try transformation(self)
    }
    
    /**
     Applying a transformation and returning the result without modifying the array itself.
     
     - parameter transformation: A closure transforming the array.
     
     - returns: An array transformed with the `transformation`.
     */
    @inlinable
    func applying(_ transformation: (inout Self) throws -> Void) rethrows -> Self {
        var array = self
        try transformation(&array)
        return array
    }
    
}

//MARK: - mutating, and non-mutating variants of common array methods
public extension Array {
    
    /// Non-mutating variant of `removeDuplicates()`.
    @inlinable
    func removingDuplicates() -> Self where Element: Equatable {
        self.applying {
            $0.removeDuplicates()
        }
    }
    
    /// Non-mutating variant `prepend()`.
    @inlinable
    func prepending(_ newElement: Element) -> Self {
        self.applying {
            $0.prepend(newElement)
        }
    }
    
    //MARK: built-in methods
    /// Non-mutating variant of Array's `append()`.
    @inlinable
    func appending(_ newElement: Element) -> Self {
        self.applying {
            $0.append(newElement)
        }
    }
    
    /// Non-mutating variant of Array's `remove(at)`.
    @inlinable
    func removing(at index: Int) -> Self {
        self.applying {
            $0.remove(at: index)
        }
    }
    
    /// Non-mutating variant of Array's `insert(_, at)`.
    @inlinable
    func inserting(_ element: Element, at index: Int) -> Self {
        self.applying {
            $0.insert(element, at: index)
        }
    }
    
    /// Non-mutating variant of Array's `removeAll(where)`.
    @inlinable
    func removingAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows -> Self {
        try self.applying {
            try $0.removeAll(where: shouldBeRemoved)
        }
    }
    
}

//MARK: - new array methods
public extension Array {
    
    /***/
    @inlinable
    mutating func prepend(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    /***/
    @inlinable
    mutating func removeDuplicates() where Element: Equatable {
        self = self.reduce([]) { items, nextItem in
            !items.contains(nextItem) ? items + [nextItem] : items
        }
    }
    
}

//MARK: - new sequence methods
public extension Sequence {
    
    /****/
    @inlinable
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>
    ) -> [Element] {
        self.sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
    
}
