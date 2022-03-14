//
//  methods.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation
import MyOthers
import MyCollections

// MARK: - (containsAny and unorderedContains)
public extension String {
    
    /// Checks if the string contains any of the specified characters
    /// - Parameter characters: 0 or more characters to be checked.
    /// - Returns: A boolean indicating whether the string contains any of the characters.
    func containsAny(_ characters: Character...) -> Bool {
        self.contains { characters.contains($0) }
    }
    
    /// Checks if the string contains any of the specified characters
    /// - Parameter characters: 0 or more characters to be checked.
    /// - Returns: A boolean indicating whether the string contains any of the characters.
    func containsAny(_ characters: CharacterSet) -> Bool {
        self.trimmingCharacters(in: characters).count == self.count
    }
    
    /// <#Description#>
    /// - Parameter other: <#other description#>
    /// - Returns: <#description#>
    func unorderedContains(_ other: String) -> Bool {
        var word = self
        
        for char in other {
            if word.contains(char) {
                word.removeFirst(char: char)
            } else { return false }
        }
        
        return true
    }
    
}

// MARK: - (removeFirst)
public extension String {
    
    /// <#Description#>
    /// - Parameter expression: <#expression description#>
    mutating func removeFirst(where expression: (Self.Element) -> Bool) {
        if let index = self.firstIndex(where: expression) {
            self.remove(at: index)
        }
    }
    
    /// <#Description#>
    /// - Parameter char: <#char description#>
    mutating func removeFirst(char: String.Element) {
        if let index = self.firstIndex(of: char) {
            self.remove(at: index)
        }
    }
}

public extension String {
    
    /// <#Description#>
    /// - Parameter locale: <#locale description#>
    mutating func lowercase(locale: Locale? = nil) {
        self.apply { $0.lowercased(with: locale) }
    }
    
    /// <#Description#>
    /// - Parameter characterSet: <#characterSet description#>
    mutating func trimCharacters(in characterSet: CharacterSet) {
        self.apply { $0.trimmingCharacters(in: characterSet) }
    }
    
}

public extension String {
    
    /// <#Description#>
    /// - Returns: <#description#>
    func paddedForPrint() -> String {
        """
        ----------------------------------

        \(self)

        ----------------------------------
        """
    }
    
    /// <#Description#>
    mutating func padForPrint() {
        self.apply { $0.paddedForPrint() }
    }
    
}

// MARK: - (getInitials)
public extension PersonNameComponentsFormatter {
    
    /// <#Description#>
    /// - Parameters:
    ///   - isPhonetic: <#isPhonetic description#>
    ///   - locale: <#locale description#>
    ///   - style: <#style description#>
    convenience init(
        isPhonetic: Bool? = nil,
        locale: Locale? = nil,
        style: Style? = nil
    ) {
        self.init()
        self.isPhonetic ?= isPhonetic
        self.locale ?= locale
        self.style ?= style
    }
    
}

public extension String {
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getInitials() -> String? {
        
        typealias Formatter = PersonNameComponentsFormatter
        
        if let components = Formatter().personNameComponents(from: self) {
            return Formatter(style: .abbreviated).string(from: components)
        } else {
            return nil
        }
    }
    
}
