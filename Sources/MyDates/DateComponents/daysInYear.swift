//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

public extension DateComponents {
    var daysInYear: Int {
        let daysInYear: Int
        
        if self.isLeapYear == true {
            daysInYear = 366
        } else {
            daysInYear = 365
        }
        
        return daysInYear
    }
}
