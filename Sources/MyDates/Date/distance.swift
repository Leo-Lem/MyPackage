//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

//MARK: implementing distance method extension to get the distance in other units
public extension Date {
    func distance(to other: Date, in unit: Calendar.Component) -> Double? {
        self
            .distance(to: other)
            .convert(to: unit)
    }
    
    func distance(
        for timespan: Calendar.Component,
        in unit: Calendar.Component = .day,
        cal: Calendar = .current
    ) -> Int? {
        if timespan == .weekOfYear && unit == .day { return 7 }
        
        let range = cal.range(of: unit, in: timespan, for: self)
        
        return range?.max()
    }
}
