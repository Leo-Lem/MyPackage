//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

public extension TimeInterval {
    
    init<V: BinaryInteger>(_ value: V, _ unit: Calendar.Component) {
        var value = TimeInterval(value)
        
        switch unit {
        case .nanosecond: value /= 1_000_000_000
        case .second: break
        case .minute: value *= 60
        case .hour: value *= (60 * 60)
        case .day: value *= (60 * 60 * 24)
        case .weekOfYear: value *= (60 * 60 * 24 * 7)
        case .month: value *= (60 * 60 * 24 * 30.41)
        case .quarter: value *= (60 * 60 * 24 * 91.3125)
        case .year: value *= (60 * 60 * 24 * 365.25)
        default: break
        }
        
        self = value
    }
    
}
