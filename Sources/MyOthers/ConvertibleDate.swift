//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 04.12.21.
//

import Foundation

//MARK: Adding easy convertability between Dates, DateComponents and String-formatted Dates
public protocol ConvertibleDate {
    typealias Defaults = ConvertibleDateSettings
    
    func getDate() -> Date
    func getString(_ dateFormat: String) -> String
    func getComponents(_ dateComponents: Set<Calendar.Component>) -> DateComponents
}

open class ConvertibleDateSettings {
    public static var dateFormat: String = "dd.MM.yyyy"
    static var dateFormatter: DateFormatter {
        DateFormatter(withDateFormat: dateFormat)
    }
    public static var dateComponents: Set<Calendar.Component> = [
        .era, .year, .yearForWeekOfYear, .quarter, .month,
        .weekOfMonth, .weekOfYear, .weekday, .weekdayOrdinal,
        .day, .hour, .minute, .second, .nanosecond
    ]
}

extension Date: ConvertibleDate {
    public func getDate() -> Date {
        self.setValues([12], for: [.hour])
    }
    public func getString(_ dateFormat: String = Defaults.dateFormat) -> String {
        DateFormatter(withDateFormat: dateFormat)
            .string(from: self)
    }
    public func getComponents(_ dateComponents: Set<Calendar.Component> = Defaults.dateComponents)-> DateComponents {
        Calendar.current
            .dateComponents(dateComponents, from: self)
    }
}

extension DateComponents: ConvertibleDate {
    public func getDate() -> Date {
        var comps = self
        comps.hour = 12
        return Calendar.current.date(from: comps)!
    }
    public func getString(_ dateFormat: String = Defaults.dateFormat) -> String {
        DateFormatter(withDateFormat: dateFormat)
            .string(from: getDate())
        
    }
    public func getComponents(_ dateComponents: Set<Calendar.Component> = Defaults.dateComponents) -> DateComponents {
        Calendar.current
            .dateComponents(dateComponents, from: getDate())
    }
}

extension String: ConvertibleDate {
    public func getDate() -> Date {
        Defaults.dateFormatter
            .date(from: self)!
    }
    
    public func getString(_ dateFormat: String = Defaults.dateFormat) -> String {
        DateFormatter(withDateFormat: dateFormat)
            .string(from: getDate())
    }
    
    public func getComponents(_ dateComponents: Set<Calendar.Component> = Defaults.dateComponents) -> DateComponents {
        Calendar.current
            .dateComponents(dateComponents, from: getDate())
    }
}
