//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

public extension Date {
    func enumerate(_ comp1: Calendar.Component, in comp2: Calendar.Component, cal: Calendar = .current) -> [Date]? {
        guard
            let start = startOf(comp2),
            let end = endOf(comp2)
        else { return nil }
        
        return Array(
            stride(from: start, to: end + TimeInterval(1, unit: comp1), by: TimeInterval(1, unit: comp1))
        )
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
            let days = daysIn(comp, for: start, cal: cal)
        else { return nil }
        
        return cal.date(byAdding: DateComponents(day: days - 1), to: start)
    }
    
    func startOfDay(cal: Calendar = .current) -> Date? {
        cal.startOfDay(for: self)
    }
    
    func daysIn(_ comp: Calendar.Component, for date: Date, cal: Calendar = .current) -> Int? {
        if comp == .weekOfYear { return 7 }
        
        let range = cal.range(of: .day, in: comp, for: date)
        
        return range?.max()
    }
}
