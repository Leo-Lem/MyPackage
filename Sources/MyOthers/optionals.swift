//
//  optionals.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation

//MARK: - Optionals
public extension Optional where Wrapped: Numeric {
    
    /// Contains either the value of the optional, or (if there is none) 0.
    var orZero: Wrapped {
        switch self {
        case .none: return 0
        case .some(let wrapped): return wrapped
        }
    }
    
}

public extension Optional {
    
    /**
     Runs the provided function only if the optional has a value.
     
     - parameter action: A function taking in the unwrapped optional as a parameter.
     */
    func then(_ action: (Wrapped) -> Void) {
        if case .some(let wrapped) = self {
            action(wrapped)
        }
    }
    
}

//MARK: - Result
public extension Result {
    
    /// Contains an optional success value.
    var optional: Success? {
        switch self {
        case .success(let success): return success
        case .failure: return nil
        }
    }
    
}

//MARK: - operators
infix operator ?=: AssignmentPrecedence
infix operator +?=: AssignmentPrecedence
infix operator -?=: AssignmentPrecedence
infix operator *?=: AssignmentPrecedence
infix operator /?=: AssignmentPrecedence

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
    
    /// Adds the optional value only if it is not nil.
    static func +?= (
        assignTo: inout Wrapped,
        optional: Self
    ) where Wrapped: AdditiveArithmetic {
        if let wrapped = optional {
            assignTo += wrapped
        }
    }
    
    /// Subtracts the optional value only if it is not nil.
    static func -?= (
        assignTo: inout Wrapped,
        optional: Self
    ) where Wrapped: AdditiveArithmetic {
        if let wrapped = optional {
            assignTo -= wrapped
        }
    }
    
    /// Multiplies by the optional value only if it is not nil.
    static func *?= (
        assignTo: inout Wrapped,
        optional: Self
    ) where Wrapped: Numeric {
        if let wrapped = optional {
            assignTo *= wrapped
        }
    }
    
    /// Divides by the optional value only if it is not nil.
    static func /?= (
        assignTo: inout Wrapped,
        optional: Self
    ) where Wrapped: BinaryFloatingPoint {
        if let wrapped = optional {
            assignTo /= wrapped
        }
    }
    
    /// Divides by the optional value only if it is not nil.
    static func /?= (
        assignTo: inout Wrapped,
        optional: Self
    ) where Wrapped: BinaryInteger {
        if let wrapped = optional {
            assignTo /= wrapped
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
