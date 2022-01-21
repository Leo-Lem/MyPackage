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
        
        return enumerate(interval, from: start, to: end, cal: cal)
    }
    
    func enumerate(
        _ interval: Calendar.Component = .day,
        in range: ClosedRange<Date>,
        cal: Calendar = .current
    ) -> [Date]? {
        enumerate(interval, from: range.lowerBound, to: range.upperBound, cal: cal)
    }
    
    func enumerate(
        _ interval: Calendar.Component = .day,
        from start: Date, to end: Date,
        cal: Calendar = .current
    ) -> [Date]? {
        Array(stride(
            from: start,
            to: end + TimeInterval(1, unit: interval),
            by: TimeInterval(1, unit: interval)
        ))
    }
}
