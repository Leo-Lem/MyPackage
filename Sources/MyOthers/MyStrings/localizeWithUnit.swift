//
//  localizeIntWithLabel.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 29.12.21.
//

import Foundation

public enum LocalizationPlurals: String {
    case seconds = "%d second(s)", minutes = "%d minute(s)", points = "%d point(s)"
}

public func localizeWithUnit<T: CVarArg>(_ value: T, label: LocalizationPlurals) -> String {
    let format = NSLocalizedString(label.rawValue, comment: "")
    
    return String.localizedStringWithFormat(format, value)
}

public func localizeUnit<T: CVarArg>(_ value: T, label: LocalizationPlurals) -> String {
    let label = label.rawValue.replacingOccurrences(of: "%d ", with: "")
    let format = NSLocalizedString(label, comment: "")
    
    return String.localizedStringWithFormat(format, value)
}
