//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import Foundation

public extension Collection where Element: ExpressibleByIntegerLiteral & AdditiveArithmetic {
    func sum() -> Element { self.reduce(0, +) }
}
