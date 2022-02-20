//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Foundation

public extension String {
    mutating func lowercase(with locale: Locale? = nil) {
        self = self.lowercased(with: locale)
    }
    
    mutating func trimCharacters(in characterSet: CharacterSet) {
        self = self.trimmingCharacters(in: characterSet)
    }
}
