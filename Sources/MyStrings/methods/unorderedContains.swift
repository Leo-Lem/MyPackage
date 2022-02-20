//
//  StringExtension.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 27.12.21.
//

import Foundation

public extension String {
    func unorderedContains(_ other: String) -> Bool {
        var word = self
        
        for char in other {
            if word.contains(char) {
                try! word.removeFirst(char: char)
            } else { return false }
        }
        
        return true
    }
}
