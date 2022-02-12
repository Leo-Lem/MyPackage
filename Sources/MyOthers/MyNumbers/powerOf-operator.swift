//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 27.01.22.
//

import Foundation

infix operator ^: DefaultPrecedence
func ^<N: BinaryInteger>(num: N, power: N) -> Double {
    pow(Double(num), Double(power))
}
