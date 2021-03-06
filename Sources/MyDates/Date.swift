//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

public extension Date {
    
    /// Returns the distance to another Date, converted to a calendar component.
    ///
    /// ```
    /// let date1 = Date(timeIntervalSinceReferenceDate: 0),
    /// date2 = Date(timeIntervalSinceReferenceDate: 1_000_000)
    ///
    /// print(date1.distance(to: date2, unit: .day, precise: true)) // 11.574074074074074
    /// print(date2.distance(to: date1, unit: .hour)) // -278.0
    /// ```
    ///
    /// - warning: Calculation is based on approximate time-interval conversions, so it may not be accurate (even when precise is true).
    /// - Parameters:
    ///   - other: A date, to which the distance should be calculated.
    ///   - unit: A calendar component, the unit in which the distance is to be calculated.
    ///   - precise: A boolean, indicating whether to apply rounding
    ///   - cal: A calendar, to set the calendar for the calculation.
    /// - Returns: The distance as a Double, or if the conversion is not possible nil.
    func distance(
        to other: Date,
        unit: Calendar.Component,
        precise: Bool = false,
        cal: Calendar = .current
    ) -> Double? {
        precise ?
            self.distance(to: other).convert(to: unit) :
            self.distance(to: other).convert(to: unit)?.rounded()
    }
    
    /// Returns the distance inside a certain calendar component, optionally converted to a calendar component.
    /// ```
    /// let date = Date(timeIntervalSinceReferenceDate: 1_000_000)
    ///
    /// print(date.distance(for: .month, unit: .day)) // 31.0
    /// print(date.distance(for: .year, unit: .hour, precise: true)) // 8759.999722222223
    /// ```
    /// - warning: Calculation is based on approximate time-interval conversions, so it may not be accurate.
    /// - Parameters:
    ///   - timespan: A calendar component, the timespan of which to calculate the distance.
    ///   - unit: A calendar component, the unit in which the distance is to be calculated.
    ///   - precise: A boolean, indicating whether to apply rounding
    ///   - cal: A calendar, to set the calendar for the calculation
    /// - Returns: The distance as a Double, or if the conversion is not possible nil.
    func distance(
        for timespan: Calendar.Component,
        unit: Calendar.Component = .second,
        precise: Bool = false,
        cal: Calendar = .current
    ) -> Double? {
        guard
            let start = startOf(timespan, cal: cal),
            let end = endOf(timespan, cal: cal)
        else { return nil }
        
        return start.distance(to: end, unit: unit, precise: precise, cal: cal)
    }
    
}



// MARK: - (startOf and endOf methods)

public extension Date {
    
    /// <#Description#>
    /// - Parameters:
    ///   - comp: <#comp description#>
    ///   - cal: <#cal description#>
    /// - Returns: <#description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - comp: <#comp description#>
    ///   - cal: <#cal description#>
    /// - Returns: <#description#>
    func endOf(_ comp: Calendar.Component, cal: Calendar = .current) -> Date? {
        guard
            let start = startOf(comp, cal: cal),
            let next = cal.date(byAdding: comp, value: 1, to: start)
        else { return nil }
        
        return next - 1
    }
    
}



// MARK: - (strideable conformance)

extension Date: Strideable {
    
    /// <#Description#>
    /// - Parameter other: <#other description#>
    /// - Returns: <#description#>
    public func distance(to other: Date) -> TimeInterval {
         other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }
    
    /// <#Description#>
    /// - Parameter n: <#n description#>
    /// - Returns: <#description#>
    public func advanced(by n: TimeInterval) -> Date { self + n }
    
}



// MARK: - (enumarating date ranges)

public extension Date {
    
    /// <#Description#>
    /// - Parameters:
    ///   - interval: <#interval description#>
    ///   - span: <#span description#>
    ///   - cal: <#cal description#>
    /// - Returns: <#description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - interval: <#interval description#>
    ///   - cal: <#cal description#>
    /// - Returns: <#description#>
    func enumerate(
        _ interval: Calendar.Component = .day,
        cal: Calendar = .current
    ) -> [Date] {
        Array(stride(from: self.lowerBound, through: self.upperBound, by: TimeInterval(1, interval)))
    }
    
}



// MARK: - (isIn methods)

public extension Date {
    
    /// <#Description#>
    /// - Parameter cal: <#cal description#>
    /// - Returns: <#description#>
    @inlinable func isInToday(cal: Calendar = .current) -> Bool { cal.isDateInToday(self) }
    
    /// <#Description#>
    /// - Parameter cal: <#cal description#>
    /// - Returns: <#description#>
    @inlinable func isInYesterday(cal: Calendar = .current) -> Bool { cal.isDateInYesterday(self) }
    
    /// <#Description#>
    /// - Parameter cal: <#cal description#>
    /// - Returns: <#description#>
    @inlinable func isInTomorrow(cal: Calendar = .current) -> Bool { cal.isDateInTomorrow(self) }
    
    /// <#Description#>
    /// - Parameters:
    ///   - date: <#date description#>
    ///   - cal: <#cal description#>
    /// - Returns: <#description#>
    @inlinable func isIn(_ date: Date, cal: Calendar = .current) -> Bool { cal.isDate(self, inSameDayAs: date) }
}
