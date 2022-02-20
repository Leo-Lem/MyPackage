//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 25.01.22.
//

import Foundation

//MARK: - accesses the first matching element in the collection
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
