//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation



// MARK: - (unit conversion on numbers)
public extension BinaryInteger {
    
    /// <#Description#>
    /// - Returns: <#description#>
    func converted<Unit: Dimension>(from input: Unit, to output: Unit) -> Double {
        let converter: (input: UnitConverter, output: UnitConverter) = (input.converter, output.converter)
        
        let input = converter.input.baseUnitValue(fromValue: Double(self))
        let output = converter.output.value(fromBaseUnitValue: input)
        
        return output
    }
    
    @inlinable mutating func convert<Unit: Dimension>(from input: Unit, to output: Unit) {
        self = Self(converted(from: input, to: output))
    }
    
}

public extension BinaryFloatingPoint {
    
    /// <#Description#>
    /// - Returns: <#description#>
    func converted<Unit: Dimension>(from input: Unit, to output: Unit) -> Double {
        let converter: (input: UnitConverter, output: UnitConverter) = (input.converter, output.converter)
        
        let input = converter.input.baseUnitValue(fromValue: Double(self))
        let output = converter.output.value(fromBaseUnitValue: input)
        
        return output
    }
    
    /// <#Description#>
    @inlinable mutating func convert<Unit: Dimension>(from input: Unit, to output: Unit) {
        self = Self(converted(from: input, to: output))
    }
    
}

public extension Double {
    
    /// <#Description#>
    @inlinable static var twoPi: Self { 2 * .pi }
    
    /// <#Description#>
    @inlinable static var halfPi: Self { pi / 2 }
    
}
