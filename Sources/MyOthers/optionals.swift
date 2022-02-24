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
