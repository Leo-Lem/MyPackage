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
        case .second: comps.formUnion([.year, .month, .day, .hour, .minute, .second])
        case .minute: comps.formUnion([.year, .month, .day, .hour, .minute])
        case .hour: comps.formUnion([.year, .month, .day, .hour])
        case .day, .weekday: comps.formUnion([.year, .month, .day])
        case .weekOfYear, .weekOfMonth: comps.formUnion([.yearForWeekOfYear, .weekOfYear])
        case .month: comps.formUnion([.year, .month])
        case .quarter: comps.formUnion([.year, .quarter])
        case .year: comps.formUnion([.year])
        default: return nil
        }
        
        return cal.dateComponents(comps, from: self).date
    }
}
