//
//  operators.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation



// MARK: - (operator overloading)

public extension Array {
    
    @inlinable static func + (lhs: Self, rhs: Self.Element) -> Self { lhs.appending(rhs) }
    @inlinable static func + (lhs: Self.Element, rhs: Self) -> Self { rhs.prepending(lhs) }
    
    @inlinable static func - (lhs: Self, rhs: Self.Element) -> Self where Element: Equatable {
        lhs.removingAll { $0 == rhs }
    }
    
    @inlinable static func += (lhs: inout Self, rhs: Self.Element) {
        lhs.append(rhs)
    }
    
    @inlinable static func -= (lhs: inout Self, rhs: Self.Element) where Element: Equatable  {
        lhs.removeAll { $0 == rhs }
    }
    
}



// MARK: - (sum operator)

prefix operator ∑

public extension Sequence where Element: AdditiveArithmetic {
    
    @inlinable prefix static func ∑ (_ sequence: Self) -> Element {
        sequence.reduce(.zero, +)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func sum() -> Element { reduce(.zero, +) }
    
}

public extension Sequence {
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func sum<T>(_ predicate: (Element) -> T) -> T where T: AdditiveArithmetic {
        self.reduce(.zero) { $0 + predicate($1) }
    }
    
}



// MARK: - (average operator)

prefix operator ∑/

public extension Collection where Element: BinaryInteger {
    
    @inlinable prefix static func ∑/ (_ collection: Self) -> Element {
        collection.average()
    }
    
    @inlinable prefix static func ∑/ <T>(_ collection: Self) -> T where T: BinaryInteger {
        collection.average()
    }
    
    @inlinable prefix static func ∑/ <T>(_ collection: Self) -> T where T: BinaryFloatingPoint {
        collection.average()
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func average() -> Element {
        isEmpty ? .zero : sum() / Element(count)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func average<T>() -> T where T: BinaryInteger {
        isEmpty ? .zero : T(sum()) / T(count)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func average<T>() -> T where T: BinaryFloatingPoint {
        isEmpty ? .zero : T(sum()) / T(count)
    }
    
}

public extension Collection where Element: BinaryFloatingPoint {
    
    @inlinable prefix static func ∑/ (_ collection: Self) -> Element {
        collection.average()
    }
    
    @inlinable prefix static func ∑/ <T>(_ collection: Self) -> T where T: BinaryFloatingPoint {
        collection.average()
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func average() -> Element {
        isEmpty ? .zero : sum() / Element(count)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func average<T>() -> T where T: BinaryFloatingPoint {
        isEmpty ? .zero : T(sum()) / T(count)
    }
    
}
