//
//  operators.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 31.12.21.
//

import Foundation

//MARK: - optionals
infix operator ?=: AssignmentPrecedence
infix operator !!: NilCoalescingPrecedence

public extension Optional {
    
    /// Assigns the optional value only if it is not nil.
    static func ?= (
        assignTo: inout Wrapped,
        optional: Self
    ) {
        if let wrapped = optional {
            assignTo = wrapped
        }
    }
    
    /// Tries unwrapping the optional, if that fails crashes an displays the error message.
    static func !! <S: StringProtocol> (
        _ optional: Self,
        errorMessage: @autoclosure () -> S
    ) -> Wrapped {
        guard let wrapped = optional else { fatalError(String(errorMessage())) }
        return wrapped
    }
}

//MARK: - Others
public extension URL {
    
    /// Returns a new url with appended appendee.
    static func + <S: StringProtocol>(
        _ url: URL,
        appendee: @autoclosure () -> S
    ) -> URL {
        url.appendingPathComponent(String(appendee()))
    }
    
    /// Returns a new url with appended appendee.
    static func / <S: StringProtocol>(
        _ url: URL,
        appendee: @autoclosure () -> S
    ) -> URL {
        url.appendingPathComponent(String(appendee()))
    }

    /// Appends a string to a url.
    static func += <S: StringProtocol>(
        _ url: inout URL,
        appendee: @autoclosure () -> S
    ) {
        url.appendPathComponent(String(appendee()))
    }
    
}
