//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import Foundation

public extension Date {
    func isInToday(cal: Calendar = .current) -> Bool { cal.isDateInToday(self) }
    func isInYesterday(cal: Calendar = .current) -> Bool { cal.isDateInYesterday(self) }
    func isInTomorrow(cal: Calendar = .current) -> Bool { cal.isDateInTomorrow(self) }
    func isIn(_ date: Date, cal: Calendar = .current) -> Bool { cal.isDate(self, inSameDayAs: date) }
}
