//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

//MARK: - allCases static property containing most date components in a set
public extension Calendar.Component {
    static var allCases: Set<Calendar.Component> {
        [
            .era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone
        ]
    }
}
