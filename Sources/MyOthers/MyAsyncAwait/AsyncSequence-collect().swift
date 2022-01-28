//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 18.01.22.
//

import Foundation

public extension AsyncSequence {
    func collect() async rethrows -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
}
