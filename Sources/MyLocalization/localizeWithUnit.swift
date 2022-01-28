//
//  localizeIntWithLabel.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 29.12.21.
//

import Foundation

public func localizeWithUnit<T: CVarArg>(_ value: T, label: LocalizationUnit) -> String {
    let format = NSLocalizedString(label.rawValue, comment: "")
    
    return String.localizedStringWithFormat(format, value)
}

public func localizeUnit<T: CVarArg>(_ value: T, label: LocalizationUnit) -> String {
    let label = label.rawValue.replacingOccurrences(of: "%d ", with: "")
    let format = NSLocalizedString(label, comment: "")
    
    return String.localizedStringWithFormat(format, value)
}
