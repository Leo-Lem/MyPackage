//
//  localization.swift
//  
//
//  Created by Leopold Lemmermann on 28.01.22.
//

import SwiftUI

// MARK: - (Localizable)
/// Constrains types which can be used for localization.
public protocol Localizable {

    /// A key value pointing to the localized value (in the localized strings file or similar).
    var key: LocalizedStringKey { get }

}

public extension Localizable {

    /// Operator implementation returning given key.
    prefix static func ~ (_ arg: Self) -> LocalizedStringKey { arg.key }

}

public extension Localizable where Self: RawRepresentable, RawValue == LocalizedStringKey {

    /// Default implementation of the requirement key for enums with a raw value of String type.
    var key: LocalizedStringKey { rawValue }

}

// MARK: - (Strings)
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

    func localize(
        _ id: String = Locale.current.languageCode ?? "en"
    ) -> String {
        guard
            let path = Bundle.main.path(forResource: id, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return String(localized: .init(self))
        }

        return String(localized: .init(self), bundle: bundle, locale: Locale(identifier: id))
    }
    
}

// MARK: - (LocalizedStringKeys)
public extension LocalizedStringKey {

    prefix static func ~ (_ arg: Self) -> LocalizedStringKey { arg }

    var key: String {
        let desc = "\(self)"

        let comp = desc.components(separatedBy: "key: \"").last,
            key = comp?.components(separatedBy: "\"").first

        return key ?? desc
    }

    func localize(_ id: String = Locale.current.languageCode ?? "en") -> String {
        guard
            let path = Bundle.main.path(forResource: id, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return String(localized: .init(key))
        }

        return String(localized: .init(key), bundle: bundle, locale: Locale(identifier: id))
    }

    init?(_ value: String?) {
        if let value = value { self.init(value) } else { return nil }
    }

}
