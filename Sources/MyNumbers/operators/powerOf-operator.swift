//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 27.01.22.
//

import Foundation

infix operator **: DefaultPrecedence
public extension Double {
    static func ** (num: Self, power: Self) -> Self { pow(num, power) }
}

public extension BinaryInteger {
    static func ** (num: Self, power: Self) -> Self { Self(pow(Double(num), Double(power))) }
}
