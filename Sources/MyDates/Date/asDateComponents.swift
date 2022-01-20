//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation
import MyOthers

//MARK: quick access to the date's components
public extension Date {
    var calendar: Calendar { Calendar.current }
    
    var asDateComponents: DateComponents {
        get { self.calendar.dateComponents(Set(Calendar.Component.allCases), from: self) }
        set { self ?= self.calendar.date(from: newValue) }
    }
}
