//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

public extension BinaryInteger {
    static func + <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) + rhs }
    static func + <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs + T(rhs) }
    
    static func - <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) - rhs }
    static func - <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs - T(rhs) }
    
    static func * <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) * rhs }
    static func * <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs * T(rhs) }
    
    static func / <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> T { T(lhs) / rhs }
    static func / <T: BinaryFloatingPoint>(lhs: T, rhs: Self) -> T { lhs / T(rhs) }
}
