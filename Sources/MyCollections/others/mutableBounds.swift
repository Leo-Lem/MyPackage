//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import Foundation

public extension ClosedRange {
    var lower: Bound {
        get { lowerBound }
        set { self = newValue...upperBound }
    }
    
    var upper: Bound {
        get { upperBound }
        set { self = lowerBound...newValue }
    }
}
