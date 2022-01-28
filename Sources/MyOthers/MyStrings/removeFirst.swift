//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Foundation

public extension String {
    enum MutatingError: Error { case noMatch }
    mutating func removeFirst(where expression: (Self.Element) -> Bool) throws {
        if let index = self.firstIndex(where: expression) {
            self.remove(at: index)
        } else {
            throw MutatingError.noMatch
        }
    }

    mutating func removeFirst(char: String.Element) throws {
        if let index = self.firstIndex(of: char) {
            self.remove(at: index)
        } else {
            throw MutatingError.noMatch
        }
    }
}
