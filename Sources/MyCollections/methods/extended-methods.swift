//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import Foundation

//MARK: - Sequence
//TODO: add documentation
public extension Sequence {
    
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
    
}
