//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

//MARK: methods for converting different time units
public extension TimeInterval {
    enum Unit { case second, minute, hour, day, week, month, year }
    
    init<V: BinaryInteger>(_ value: V, unit: TimeInterval.Unit) {
        var value = TimeInterval(value)
        
        switch unit {
        case .minute: value *= 60
        case .hour: value *= (60 * 60)
        case .day: value *= (60 * 60 * 24)
        case .week: value *= (60 * 60 * 24 * 7)
        case .month: value *= (60 * 60 * 24 * 30.41)
        case .year: value *= (60 * 60 * 24 * 365.25)
        default: break
        }
        
        self = value
    }
    
    func convert(to unit: TimeInterval.Unit) -> Double {
        var value = self
        
        switch unit {
        case .minute: value /= 60
        case .hour: value /= (60 * 60)
        case .day: value /= (60 * 60 * 24)
        case .week: value /= (60 * 60 * 24 * 7)
        case .month: value /= (60 * 60 * 24 * 30.41)
        case .year: value /= (60 * 60 * 24 * 365.25)
        default: break
        }
        
        return value
    }
}
