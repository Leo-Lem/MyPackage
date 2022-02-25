//
//  others.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation

//MARK: - Collections
public extension Collection where Index == Int {
    
    ///
    @inlinable
    var lastIndex: Int { self.endIndex - 1 }
    
}

//MARK: - ClosedRange mutable bounds
public extension ClosedRange {
    
    ///
    var mutableLowerBound: Bound {
        get { lowerBound }
        set { self = newValue...upperBound }
    }
    
    ///
    var mutableUpperBound: Bound {
        get { upperBound }
        set { self = lowerBound...newValue }
    }
    
}

public extension Range {
    
    ///
    var mutableLowerBound: Bound {
        get { lowerBound }
        set { self = newValue..<upperBound }
    }
    
    ///
    var mutableUpperBound: Bound {
        get { upperBound }
        set { self = lowerBound..<newValue }
    }
    
}
