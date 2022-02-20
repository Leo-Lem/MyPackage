//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

public extension Date {
    /**
     Returns the distance to another Date, converted to a calendar component.
     
        ```
     let date1 = Date(timeIntervalSinceReferenceDate: 0),
         date2 = Date(timeIntervalSinceReferenceDate: 1_000_000)

     print(date1.distance(to: date2, unit: .day, precise: true)) // 11.574074074074074
     print(date2.distance(to: date1, unit: .hour)) // -278.0
        ```
     - warning: Calculation is based on approximate time-interval conversions, so it may not be accurate (even when precise is true).
     
     - parameters:
        - to: A date, to which the distance should be calculated.
        - unit: A calendar component, the unit in which the distance is to be calculated.
        - precise: A boolean, indicating whether to apply rounding
        - cal: A calendar, to set the calendar for the calculation.
     
     - returns: A Double, or if the conversion is not possible nil.
     */
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
    
    /**
     Returns the distance inside a certain calendar component, optionally converted to a calendar component.
     
        ```
     let date = Date(timeIntervalSinceReferenceDate: 1_000_000)

     print(date.distance(for: .month, unit: .day)) // 31.0
     print(date.distance(for: .year, unit: .hour, precise: true)) // 8759.999722222223
        ```
     - warning: Calculation is based on approximate time-interval conversions, so it may not be accurate.
     
     - parameters:
        - for: A calendar component, the timespan of which to calculate the distance.
        - unit: A calendar component, the unit in which the distance is to be calculated.
        - precise: A boolean, indicating whether to apply rounding
        - cal: A calendar, to set the calendar for the calculation
     
     - returns: A Double, or if the conversion is not possible nil.
     */
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
