//
//  async.swift
// 
//
//  Created by Leopold Lemmermann on 26.01.22.
//

import Foundation

//MARK: - Sequence
public extension Sequence {
    
    /***/
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
    
    /***/
    func asyncCompactMap<T>(
        _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            guard let transformedElement = try await transform(element) else { continue }
            values.append(transformedElement)
        }
        
        return values
    }
    
}

//MARK: - AsyncSequence
public extension AsyncSequence {
    
    /***/
    func collect() async rethrows -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
    
}
