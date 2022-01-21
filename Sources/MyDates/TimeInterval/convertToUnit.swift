//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 21.01.22.
//

import Foundation

public extension TimeInterval {
    
    func convert(to unit: Calendar.Component) -> Double? {
        var value = self
        
        switch unit {
        case .minute: value /= 60
        case .hour: value /= (60 * 60)
        case .day: value /= (60 * 60 * 24)
        case .weekOfYear: value /= (60 * 60 * 24 * 7)
        case .month: value /= (60 * 60 * 24 * 30.41)
        case .year: value /= (60 * 60 * 24 * 365.25)
        default: return nil
        }
        
        return value
    }
    
}
