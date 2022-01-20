//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

public extension DateComponents {
    var daysInMonth: Int {
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
