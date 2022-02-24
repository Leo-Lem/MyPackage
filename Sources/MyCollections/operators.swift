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
    static func + (
        lhs: Self,
        rhs: Self.Element
    ) -> Self {
        lhs.appending(rhs)
    }
    
    /***/
    static func + (
        lhs: Self.Element,
        rhs: Self
    ) -> Self {
        rhs.prepending(lhs)
    }
    
    /***/
    static func - (
        lhs: Self,
        rhs: Self.Element
    ) -> Self where Element: Equatable {
        lhs.removingAll { $0 == rhs }
    }
    
    /***/
    static func - (
        lhs: Self.Element,
        rhs: Self
    ) -> Self where Element: Equatable {
        rhs.removingAll { $0 == lhs }
    }
    
    /***/
    static func += (
        lhs: inout Self,
        rhs: Self.Element
    ) {
        lhs.append(rhs)
    }
    
    /***/
    static func -= (
        lhs: inout Self,
        rhs: Self.Element
    ) where Element: Equatable  {
        lhs.removeAll { $0 == rhs }
    }
    
}

//MARK: - sum operator
prefix operator ∑
public extension Sequence where Element: Numeric {
    
    /***/
    prefix static func ∑ (
        _ sequence: Self
    ) -> Element {
        sequence.reduce(0, +)
    }
    
}
