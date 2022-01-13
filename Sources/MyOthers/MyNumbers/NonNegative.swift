//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value
    
    var wrappedValue: Value {
        get { value }
        set { value = newValue < 0 ? 0 : newValue }
    }
    
    init(wrappedValue: Value) {
        value = wrappedValue < 0 ? 0 : wrappedValue
    }
}
