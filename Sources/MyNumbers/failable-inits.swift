//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 07.02.22.
//

import Foundation

public extension Double {
    init?<V: BinaryInteger>(_ value: V?) {
        guard let value = value else { return nil }
        self.init(value)
    }
}

public extension Int {
    init?(value: Double?) {
        guard let value = value else { return nil }
        self.init(value)
    }
}

