//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Foundation

extension String {
    public mutating func lowercase(with locale: Locale? = nil) {
        self = self.lowercased(with: locale)
    }
    
    public mutating func trimCharacters(in characterSet: CharacterSet) {
        self = self.trimmingCharacters(in: characterSet)
    }
    
    public mutating func logPad() {
        self = self.logPadded()
    }
}
