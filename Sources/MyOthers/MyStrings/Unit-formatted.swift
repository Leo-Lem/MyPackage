//
//  Unit-formatted.swift
//  Units
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import Foundation

public extension Unit {
    func formatted(_ style: Formatter.UnitStyle) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = style
        return formatter.string(from: self)
    }
}
