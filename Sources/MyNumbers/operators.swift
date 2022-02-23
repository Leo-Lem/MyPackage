//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

//MARK: - approx
infix operator ≈: AssignmentPrecedence
public extension Double {
    static func ≈ <T: BinaryInteger>(lhs: inout T, rhs: Self) {
        lhs = T(rhs)
    }
}

//MARK: - increment/decrement
postfix operator +
postfix operator -
public extension AdditiveArithmetic where Self: ExpressibleByIntegerLiteral {
    postfix static func + (num: Self) -> Self { num + 1 }
    postfix static func - (num: Self) -> Self { num - 1 }
}

postfix operator ++
postfix operator --
public extension AdditiveArithmetic where Self: ExpressibleByIntegerLiteral {
    postfix static func ++ (num: inout Self) { num += 1 }
    postfix static func -- (num: inout Self) { num -= 1 }
}

//MARK: - powerOf
infix operator **: DefaultPrecedence
public extension Double {
    static func ** (num: Self, power: Self) -> Self { pow(num, power) }
}

public extension BinaryInteger {
    static func ** (num: Self, power: Self) -> Self { Self(pow(Double(num), Double(power))) }
}
