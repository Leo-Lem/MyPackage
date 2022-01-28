//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 21.01.22.
//

import Foundation

public extension Date {
    func startOf(_ comp: Calendar.Component, cal: Calendar = .current) -> Date? {
        var comps: Set<Calendar.Component> = [.calendar]
        
        switch comp {
        case .day: comps.formUnion([.day, .month, .year])
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
            let days = distance(for: comp, cal: cal)
        else { return nil }
        
        return cal.date(byAdding: DateComponents(day: days, second: -1), to: start)
    }

    func startOfDay(cal: Calendar = .current) -> Date? { cal.startOfDay(for: self) }
}
