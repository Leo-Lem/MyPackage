//
//  localization.swift
//  
//
//  Created by Leopold Lemmermann on 28.01.22.
//

import Foundation

//MARK: - localized operator
postfix operator ~

public extension String {
    
    /***/
    postfix static func ~ (
        string: Self
    ) -> String {
        NSLocalizedString(string, comment: "")
    }
    
}

//MARK: - localize with unit
public extension String {
    
    /// Represents a localized unit, which (in combination with the Localizable stringsdict) provides localized plurals.
    enum LocalizationUnit {
        case seconds, minutes, points, cups
        
        /// The key for looking up the unit in the Localizable stringsdict
        var key: String {
            switch self {
            case .seconds: return "second(s)"
            case .minutes: return "minute(s)"
            case .points: return "point(s)"
            case .cups: return "cup(s)"
            }
        }
        
        /// The key for looking up the unit with a value in the Localizable stringsdict
        var keyWithValue: String { "%d " + key }
    }
    
    /***/
    static func localizeWithUnit<T: CVarArg>(
        _ value: T,
        label: LocalizationUnit,
        unitOnly: Bool = false
    ) -> Self {
        let format = NSLocalizedString(unitOnly ? label.key : label.keyWithValue, comment: "")
        
        return String.localizedStringWithFormat(format, value)
    }
    
}
