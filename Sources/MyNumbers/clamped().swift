//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

public func clamped<T: Comparable>(_ value: T, bounds: (min: T, max: T)) -> T {
    Swift.min(Swift.max(value, bounds.min), bounds.max)
}
