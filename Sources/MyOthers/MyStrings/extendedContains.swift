//
//  StringExtension.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 27.12.21.
//

import Foundation

extension String {
    public func extendedContains(_ other: String) -> Bool {
        var word = self
        
        for char in other {
            if word.contains(char) {
                try! word.removeFirst(char: char)
            } else { return false }
        }
        
        return true
    }
}
