//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

public extension Date {
    
    func enumerate(
        _ interval: Calendar.Component = .day,
        in span: Calendar.Component,
        cal: Calendar = .current
    ) -> [Date]? {
        guard let start = startOf(span), let end = endOf(span) else { return nil }
        
        return (start...end).enumerate(interval, cal: cal)
    }
    
}

public extension ClosedRange where Bound == Date {
    
    func enumerate(
        _ interval: Calendar.Component = .day,
        cal: Calendar = .current
    ) -> [Date] {
        Array(stride(from: self.lowerBound, through: self.upperBound, by: TimeInterval(1, interval)))
    }
    
}
