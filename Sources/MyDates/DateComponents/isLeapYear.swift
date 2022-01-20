//
//  daysInMonthComponent.swift
//  AshtraySwiftUI
//
//  Created by Leopold Lemmermann on 19.12.21.
//

import Foundation

public extension DateComponents {
    var isLeapYear: Bool {
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
}
