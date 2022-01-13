//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

@propertyWrapper
public struct Lowercased<Value: StringProtocol> {
    public var value: Value
    
    public var wrappedValue: Value {
        get { value }
        set { self.value = Value(stringLiteral: newValue.lowercased()) }
    }
    
    public init(wrappedValue: Value) {
        self.value = Value(stringLiteral: wrappedValue.lowercased())
    }
}

@propertyWrapper
public struct Uppercased<Value: StringProtocol> {
    public var value: Value
    
    public var wrappedValue: Value {
        get { value }
        set { self.value = Value(stringLiteral: newValue.uppercased()) }
    }
    
    public init(wrappedValue: Value) {
        self.value = Value(stringLiteral: wrappedValue.lowercased())
    }
}
