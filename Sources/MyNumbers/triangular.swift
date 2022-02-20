//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

public extension BinaryInteger {
    var triangular: Self { Self(Array(1...Int(self)).reduce(0, +)) }
}
