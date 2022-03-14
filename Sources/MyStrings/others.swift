//
//  others.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

public extension String {
    
    /// <#Description#>
    /// - Parameter length: <#length description#>
    /// - Returns: <#description#>
    static func placeholder(length: Int) -> String {
        String(repeating: "X", count: length)
    }
    
    /// Gives the length of the string after trimming whitespaces and new lines.
    var countWithoutWhitespaceAndNewlines: Int {
        self.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    
    /// <#Description#>
    var givenName: String? {
        let formatter = PersonNameComponentsFormatter()
        let comps = formatter.personNameComponents(from: self)
        return comps?.givenName
    }
    
}

// MARK: - (unit formatting)
public extension Unit {
    
    /// <#Description#>
    /// - Parameter style: <#style description#>
    /// - Returns: <#description#>
    func formatted(_ style: Formatter.UnitStyle) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = style
        return formatter.string(from: self)
    }
    
}
