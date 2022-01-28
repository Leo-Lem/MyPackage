//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

public extension BinaryInteger {
    static func *(lhs: Self, rhs: Double) -> Double { Double(lhs) * rhs }
    static func *(lhs: Double, rhs: Self) -> Double { lhs * Double(rhs) }
}
