//
//  operators.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

//MARK: - operator overloading
public extension Array {
    
    /***/
    @inlinable
    static func + (
        lhs: Self,
        rhs: Self.Element
    ) -> Self {
        lhs.appending(rhs)
    }
    
    /***/
    @inlinable
    static func + (
        lhs: Self.Element,
        rhs: Self
    ) -> Self {
        rhs.prepending(lhs)
    }
    
    /***/
    @inlinable
    static func - (
        lhs: Self,
        rhs: Self.Element
    ) -> Self where Element: Equatable {
        lhs.removingAll { $0 == rhs }
    }
    
    /***/
    @inlinable
    static func - (
        lhs: Self.Element,
        rhs: Self
    ) -> Self where Element: Equatable {
        rhs.removingAll { $0 == lhs }
    }
    
    /***/
    @inlinable
    static func += (
        lhs: inout Self,
        rhs: Self.Element
    ) {
        lhs.append(rhs)
    }
    
    /***/
    @inlinable
    static func -= (
        lhs: inout Self,
        rhs: Self.Element
    ) where Element: Equatable  {
        lhs.removeAll { $0 == rhs }
    }
    
}

//MARK: - sum operator
prefix operator ∑

public extension Sequence where Element: AdditiveArithmetic {
    
    /***/
    @inlinable
    prefix static func ∑ (
        _ sequence: Self
    ) -> Element {
        sequence.reduce(.zero, +)
    }
    
    /***/
    @inlinable
    func sum() -> Element {
        reduce(.zero, +)
    }
    
}

public extension Sequence {
    
    /***/
    @inlinable
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T {
        self.reduce(.zero) { $0 + predicate($1) }
    }
    
}


//MARK: - average operator
prefix operator ∑/

public extension Collection where Element: BinaryInteger {
    
    ///
    prefix static func ∑/ (
        _ collection: Self
    ) -> Element {
        collection.average()
    }
    
    /***/
    func average() -> Element {
        isEmpty ? .zero : sum() / Element(count)
    }
    
    ///
    prefix static func ∑/ <T: BinaryInteger>(
        _ collection: Self
    ) -> T {
        collection.average()
    }
    
    /***/
    func average<T: BinaryInteger>() -> T {
        isEmpty ? .zero : T(sum()) / T(count)
    }
    
    ///
    prefix static func ∑/ <T: BinaryFloatingPoint>(
        _ collection: Self
    ) -> T {
        collection.average()
    }
    
    /***/
    func average<T: BinaryFloatingPoint>() -> T {
        isEmpty ? .zero : T(sum()) / T(count)
    }
    
}

public extension Collection where Element: BinaryFloatingPoint {
    
    ///
    prefix static func ∑/ (
        _ collection: Self
    ) -> Element {
        collection.average()
    }
    
    /***/
    func average() -> Element {
        isEmpty ? .zero : sum() / Element(count)
    }
    
    ///
    prefix static func ∑/ <T: BinaryFloatingPoint>(
        _ collection: Self
    ) -> T {
        collection.average()
    }
    
    /***/
    func average<T: BinaryFloatingPoint>() -> T {
        isEmpty ? .zero : T(sum()) / T(count)
    }
    
}
