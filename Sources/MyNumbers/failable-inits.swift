//
//  failable-inits.swift
//  
//
//  Created by Leopold Lemmermann on 07.02.22.
//

import Foundation

public extension BinaryFloatingPoint {
    
    init?<V: BinaryInteger>(_ value: V?) {
        guard let value = value else { return nil }
        self.init(value)
    }
    
}

public extension BinaryInteger {
    
    init?<V: BinaryFloatingPoint>(value: V?) {
        guard let value = value else { return nil }
        self.init(value)
    }
    
}

