//
//  subscripts.swift
//  
//
//  Created by Leopold Lemmermann on 25.01.22.
//

import Foundation



// MARK: - (element subscript)

public extension MutableCollection where Element: Equatable {
    
    subscript(element element: Element) -> Element? {
        get {
            guard let index = self.firstIndex(of: element) else { return nil }
            return self[index]
        }
        set {
            if let index = self.firstIndex(of: element), let value = newValue {
                self[index] = value
            }
        }
    }
    
}



// MARK: - (optional subscript)

public extension Collection where Indices.Iterator.Element == Index {
    
    subscript(optional index: Index) -> Iterator.Element? {
        (startIndex <= index && index < endIndex) ? self[index] : nil
    }
    
}
