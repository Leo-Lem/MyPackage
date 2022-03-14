//
//  methods.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation



// MARK: - (conversion to non-mutating and mutating methods respectively)

public extension Sequence {
    
    /// Applies a transformation and returns the result without modifying the array itself.
    /// - Parameter transformation: A closure taking the array as parameter yielding a transformed array.
    @inlinable mutating func apply(_ transformation: (Self) throws -> Self) rethrows {
        self = try transformation(self)
    }
    
    /// Applying a transformation and returning the result without modifying the array itself.
    /// - Parameter transformation: A closure transforming the array.
    /// - Returns: An array transformed with the `transformation`.
    @inlinable func applying(_ transformation: (inout Self) throws -> Void) rethrows -> Self {
        var array = self
        try transformation(&array)
        return array
    }
    
}



// MARK: - (new methods)

public extension Sequence {

    /// Allows sorting of the sequence by key paths.
    /// - Parameter keyPath: The key path leading to a comparable value by which to sort.
    /// - Returns: An array with the sorted elements of the sequence.
    @inlinable func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>
    ) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }

    /// Allows sorting of the sequence by key paths.
    /// - Parameters:
    ///   - keyPath: The key path leading to a value by which to sort.
    ///   - areInIncreasingOrder: A function describing how to order the values at the key path.
    /// - Returns: An array with the sorted elements of the sequence.
    @inlinable func sorted<Value>(
        by keyPath: KeyPath<Element, Value>,
        using areInIncreasingOrder: (Value, Value) throws -> Bool
    ) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    /// Removes all duplicates from the sequence.
    /// - Returns: An array without duplicates.
    /// - Note: Works when the elements are equatable..
    @inlinable func removingDuplicates<T: Equatable>(
        by accessor: (Element) -> T
    ) -> [Element] {
        self.reduce([]) { items, next in
            let duplicate = items.contains { accessor($0) == accessor(next) }
            
            return duplicate ? items : items + next
        }
    }
    
    /// Removes all duplicates from the sequence.
    /// - Returns: An array without duplicates.
    /// - Note: Works when the elements are equatable..
    @inlinable func removingDuplicates() -> [Element] where Element: Equatable {
        removingDuplicates { $0 }
    }
    
    /// Removes all duplicates from the sequence.
    /// - Returns: An array without duplicates.
    /// - Note: Works when the elements are hashable.
    func uniqueElements<T: Hashable>(
        by accessor: (Element) -> T
    ) -> [Element] {
        var seen = Set<T>()
        
        return filter { seen.insert(accessor($0)).inserted }
    }
    
    /// Removes all duplicates from the sequence.
    /// - Returns: An array without duplicates.
    /// - Note: Works when the elements are hashable.
    @inlinable func uniqueElements() -> [Element] where Element: Hashable {
        uniqueElements { $0 }
    }
    
    /// Removes all nil values from the sequence.
    /// - Returns: An array containing all non-nil values of the sequence.
    @inlinable func compact() -> [Element] { self.compactMap({ $0 }) }

}

public extension Array {
    
    /// Prepends an element to the front of the array (position 0).
    /// - Parameter newElement: The element to prepend.
    @inlinable mutating func prepend(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
}

public extension Dictionary {

    /// Transforms dictionary keys without modifying values.
    /// Deduplicates transformed keys.
    ///
    /// Example:
    /// ```
    /// ["one": 1, "two": 2, "three": 3, "": 4].mapKeys({ $0.first }, uniquingKeysWith: { max($0, $1) })
    /// // [Optional("o"): 1, Optional("t"): 3, nil: 4]
    /// ```
    ///
    /// - Parameters:
    ///   - transform: A closure that accepts each key of the dictionary as
    ///   its parameter and returns a transformed key of the same or of a different type.
    ///   - combine:A closure that is called with the values for any duplicate
    ///   keys that are encountered. The closure returns the desired value for
    ///   the final dictionary.
    /// - Returns: A dictionary containing the transformed keys and values of this dictionary.
    func mapKeys<T>(
        _ transform: (Key) throws -> T,
        uniquingKeysWith combine: (Value, Value) throws -> Value
    ) rethrows -> [T: Value] {
        try .init(
            map { (try transform($0.key), $0.value) },
            uniquingKeysWith: combine
        )
    }

    /// Transforms dictionary keys without modifying values.
    /// Drops (key, value) pairs where the transform results in a nil key.
    /// Deduplicates transformed keys.
    ///
    /// Example:
    /// ```
    /// ["one": 1, "two": 2, "three": 3, "": 4].compactMapKeys({ $0.first }, uniquingKeysWith: { max($0, $1) })
    /// // ["o": 1, "t": 3]
    /// ```
    ///
    /// - Parameters:
    ///   - transform: A closure that accepts each key of the dictionary as
    ///   its parameter and returns an optional transformed key of the same or of a different type.
    ///   - combine: A closure that is called with the values for any duplicate
    ///   keys that are encountered. The closure returns the desired value for
    ///   the final dictionary.
    /// - Returns: A dictionary containing the non-nil transformed keys and values of this dictionary.
    func compactMapKeys<T>(
        _ transform: (Key) throws -> T?,
        uniquingKeysWith combine: (Value, Value) throws -> Value
    ) rethrows -> [T: Value] {
        try .init(
            compactMap { (try transform($0.key), $0.value) as? (T, Value) },
            uniquingKeysWith: combine
        )
    }

}



// MARK: - (mutating, and non-mutating variants of common array methods)

public extension Array {
    
    /// Non-mutating variant of `removingDuplicates()`.
    @inlinable mutating func removeDuplicates() where Element: Equatable {
        self.apply {
            $0.removingDuplicates()
        }
    }
    
    /// Non-mutating variant of `removingDuplicates()`.
    @inlinable mutating func uniqueElements() where Element: Hashable {
        self.apply {
            $0.removingDuplicates()
        }
    }
    
    /// Non-mutating variant `prepend()`.
    /// - Parameter newElement: The element to prepend.
    /// - Returns: The array after prepending the element.
    @inlinable func prepending(_ newElement: Element) -> Self {
        self.applying {
            $0.prepend(newElement)
        }
    }
    
    /// Non-mutating variant of Array's `append()`.
    /// - Parameter newElement: The element to append.
    /// - Returns: The array after appending the element.
    @inlinable func appending(_ newElement: Element) -> Self {
        self.applying {
            $0.append(newElement)
        }
    }
    
    /// Non-mutating variant of Array's `remove(at)`.
    /// - Parameter index: The index at which to remove the element.
    /// - Returns: The array after removing the element.
    @inlinable func removing(at index: Int) -> Self {
        self.applying {
            $0.remove(at: index)
        }
    }
    
    /// Non-mutating variant of Array's `insert(_, at)`.
    /// - Parameters:
    ///   - element: The element to insert.
    ///   - index: The position of the insertion.
    /// - Returns: The array after inserting the element at the index.
    @inlinable func inserting(_ element: Element, at index: Int) -> Self {
        self.applying {
            $0.insert(element, at: index)
        }
    }
    
    /// Non-mutating variant of Array's `removeAll(where)`.
    /// - Parameter shouldBeRemoved: A predicate closure for determining items to be removed.
    /// - Returns: The array ater removing all items matching the predicate.
    @inlinable func removingAll(
        where shouldBeRemoved: (Element) throws -> Bool
    ) rethrows -> Self {
        try self.applying {
            try $0.removeAll(where: shouldBeRemoved)
        }
    }
    
}
