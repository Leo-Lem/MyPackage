//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

//MARK: quick access to some date components of a date
public extension Date {
    var day: Int {
        get { self.asDateComponents.day ?? 1 }
        set { self.asDateComponents.day = newValue }
    }
    
    var month: Int {
        get { self.asDateComponents.month ?? 1 }
        set { self.asDateComponents.month = newValue }
    }
    
    var hour: Int {
        get { self.asDateComponents.hour ?? 1 }
        set { self.asDateComponents.hour = newValue }
    }
    
    var year: Int {
        get { self.asDateComponents.year ?? 1 }
        set { self += TimeInterval(year - newValue, unit: .year) }
    }
    
    var weekday: Int {
        get { self.asDateComponents.weekday ?? 1 }
        set { self += TimeInterval(weekday - newValue, unit: .day) }
    }
}
