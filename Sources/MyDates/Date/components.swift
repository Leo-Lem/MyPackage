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
    
    func startOf(_ comp: Calendar.Component, cal: Calendar = .current) -> Date? {
        var comps: Set<Calendar.Component> = [.calendar]
        
        switch comp {
        case .weekOfYear: comps.formUnion([.yearForWeekOfYear, .weekOfYear])
        case .month: comps.formUnion([.year, .month])
        case .year: comps.formUnion([.year])
        default: return nil
        }
        
        return cal.dateComponents(comps, from: self).date
    }
    
    func endOf(_ comp: Calendar.Component, cal: Calendar = .current) -> Date? {
        guard
            let start = startOf(comp),
            let days = daysIn(comp, cal: cal)
        else { return nil }
        
        return cal.date(byAdding: DateComponents(day: days - 1), to: start)
    }
    
    func startOfDay(cal: Calendar = .current) -> Date? {
        cal.startOfDay(for: self)
    }
    
    func daysIn(_ comp: Calendar.Component, cal: Calendar = .current) -> Int? {
        if comp == .weekOfYear { return 7 }
        
        let range = cal.range(of: .day, in: comp, for: self)
        
        return range?.max()
    }
}
