//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

extension BinaryInteger {
    public static func *(lhs: Self, rhs: Double) -> Double {
        Double(lhs) * rhs
    }
    
    public static func *(lhs: Double, rhs: Self) -> Double {
        lhs * Double(rhs)
    }
}
