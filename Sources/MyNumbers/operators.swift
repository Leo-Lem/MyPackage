//
//  operators.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation



// MARK: - (approx)

infix operator ≈: AssignmentPrecedence

public extension Double {
    @inlinable static func ≈ <T: BinaryInteger>(lhs: inout T, rhs: Self) { lhs = T(rhs) }
}



// MARK: - (increment/decrement)

postfix operator +
postfix operator -

public extension AdditiveArithmetic where Self: ExpressibleByIntegerLiteral {
    @inlinable postfix static func + (num: Self) -> Self { num + 1 }
    @inlinable postfix static func - (num: Self) -> Self { num - 1 }
}

postfix operator ++
postfix operator --

public extension AdditiveArithmetic where Self: ExpressibleByIntegerLiteral {
    @inlinable postfix static func ++ (num: inout Self) { num += 1 }
    @inlinable postfix static func -- (num: inout Self) { num -= 1 }
}



// MARK: - (powerOf)

infix operator **: DefaultPrecedence

public extension Double {
    @inlinable static func ** (num: Self, power: Self) -> Self { pow(num, power) }
}

public extension BinaryInteger {
    @inlinable static func ** (num: Self, power: Self) -> Self { Self(pow(Double(num), Double(power))) }
}



// MARK: - (extended arithmetics)

public extension BinaryInteger {
    @inlinable static func + <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) + rhs }
    @inlinable static func + <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs + T(rhs) }
    
    @inlinable static func - <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) - rhs }
    @inlinable static func - <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs - T(rhs) }
    
    @inlinable static func * <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) * rhs }
    @inlinable static func * <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs * T(rhs) }
    
    @inlinable static func / <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) / rhs }
    @inlinable static func / <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs / T(rhs) }
}



// MARK: - (min, max, clamped)

infix operator <|: AssignmentPrecedence
infix operator |<: AssignmentPrecedence

public extension Comparable {
    
    /// Max operator, bounds a value with an upper bound.
    @inlinable static func <| (_ value: Self, upperBound: Self) -> Self {
        min(value, upperBound)
    }
    
    /// Min operator, bounds a value with a lower bound
    @inlinable static func |< (lowerBound: Self, _ value: Self) -> Self {
        max(value, lowerBound)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - lowerBound: <#lowerBound description#>
    ///   - upperBound: <#upperBound description#>
    /// - Returns: <#description#>
    @inlinable static func clamped(
        _ value: Self,
        lowerBound: Self,
        upperBound: Self
    ) -> Self {
        lowerBound |< value <| upperBound
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - lowerBound: <#lowerBound description#>
    ///   - upperBound: <#upperBound description#>
    @inlinable mutating func clamp(lowerBound: Self, upperBound: Self) {
        self = Self.clamped(self, lowerBound: lowerBound, upperBound: upperBound)
    }
    
}



// MARK: - (triangular operator)

prefix operator ∆

public extension BinaryInteger {
    
    @inlinable prefix static func ∆ (_ num: Self) -> Self { num.triangular() }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func triangular() -> Self {
        Self(Array(1...Int(self)).reduce(0, +))
    }
    
}

// MARK: - (spaceship operator)

infix operator <=>

public extension Comparable {
    
    static func <=> (lhs: Self, rhs: Self) -> ComparisonResult {
        if lhs < rhs { return .orderedAscending }
        if lhs > rhs { return .orderedDescending }
        return .orderedSame
    }
    
    /// <#Description#>
    /// - Parameter other: <#other description#>
    /// - Returns: <#description#>
    @inlinable func compare(to other: Self) -> ComparisonResult { self <=> other }
    
}

public extension BinaryInteger {
    
    static func <=> <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> ComparisonResult {
        T(lhs) <=> rhs
    }
    
    static func <=> <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> ComparisonResult {
        lhs <=> T(rhs)
    }
    
}
