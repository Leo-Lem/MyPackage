//
//  daysInMonthComponent.swift
//  AshtraySwiftUI
//
//  Created by Leopold Lemmermann on 19.12.21.
//

import Foundation

extension DateComponents {
    public var isLeapYear: Bool {
        let isLeapYear: Bool
        
        guard let year = self.year else {
            return false
        }
        
        if year % 4 != 0 {
            isLeapYear = false
        } else if year % 100 != 0 {
            isLeapYear = true
        } else if year % 400 != 0 {
            isLeapYear = false
        } else {
            isLeapYear = true
        }
        
        return isLeapYear
    }
    
    public var daysInYear: Int {
        let daysInYear: Int
        
        if self.isLeapYear == true {
            daysInYear = 366
        } else {
            daysInYear = 365
        }
        
        return daysInYear
    }
    
    public var daysInMonth: Int {
        let daysInMonth: Int
        
        switch self.month {
        case 1: daysInMonth = 31
        case 2:
            if self.isLeapYear { daysInMonth = 29 }
            else { daysInMonth = 28 }
        case 3: daysInMonth = 31
        case 4: daysInMonth = 30
        case 5: daysInMonth = 31
        case 6: daysInMonth = 30
        case 7: daysInMonth = 31
        case 8: daysInMonth = 31
        case 9: daysInMonth = 30
        case 10: daysInMonth = 31
        case 11: daysInMonth = 30
        case 12: daysInMonth = 31
        default: daysInMonth = 0
        }
        
        return daysInMonth
    }
}
