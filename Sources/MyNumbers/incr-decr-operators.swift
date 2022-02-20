//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

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
