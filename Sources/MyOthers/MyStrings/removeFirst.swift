//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Foundation

extension String {
    public enum MutatingError: Error { case noMatch }
    public mutating func removeFirst(where expression: (Self.Element) -> Bool) throws {
        if let index = self.firstIndex(where: expression) {
            self.remove(at: index)
        } else {
            throw MutatingError.noMatch
        }
    }

    public mutating func removeFirst(char: String.Element) throws {
        if let index = self.firstIndex(of: char) {
            self.remove(at: index)
        } else {
            throw MutatingError.noMatch
        }
    }
}
