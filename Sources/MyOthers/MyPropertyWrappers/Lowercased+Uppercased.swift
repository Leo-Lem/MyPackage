//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

@propertyWrapper
struct Lowercased<Value: StringProtocol> {
    var value: Value
    
    var wrappedValue: Value {
        get { value }
        set { self.value = Value(stringLiteral: newValue.lowercased()) }
    }
    
    init(wrappedValue: Value) {
        self.value = Value(stringLiteral: wrappedValue.lowercased())
    }
}

@propertyWrapper
struct Uppercased<Value: StringProtocol> {
    var value: Value
    
    var wrappedValue: Value {
        get { value }
        set { self.value = Value(stringLiteral: newValue.uppercased()) }
    }
    
    init(wrappedValue: Value) {
        self.value = Value(stringLiteral: wrappedValue.lowercased())
    }
}
