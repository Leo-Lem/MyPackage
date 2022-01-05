//
//  localizeIntWithLabel.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 29.12.21.
//

import Foundation

enum LocalizationPlurals: String {
    case seconds = "%d second(s)", minutes = "%d minute(s)", points = "%d point(s)"
}

func localizeWithUnit<T: CVarArg>(_ value: T, label: LocalizationPlurals) -> String {
    let format = NSLocalizedString(label.rawValue, comment: "")
    
    return String.localizedStringWithFormat(format, value)
}
