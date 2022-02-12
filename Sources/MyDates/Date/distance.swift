//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation
import MyOthers

//MARK: implementing distance method extension to get the distance in other units
public extension Date {
    func distance(
        to other: Date,
        unit: Calendar.Component,
        rounded: Bool = false,
        cal: Calendar = .current
    ) -> Double? {
        rounded ? Double(cal.dateComponents([unit], from: self, to: other).value(for: unit)) : self.distance(to: other).convert(to: unit)
    }
    
    func distance(
        for timespan: Calendar.Component,
        unit: Calendar.Component,
        cal: Calendar = .current
    ) -> Int? {
        if timespan == unit { return 1 }
        
        switch (timespan, unit) {
        case (.weekOfYear, .day), (.weekOfMonth, .day): return 7
        default:
            guard let end = cal.range(of: unit, in: timespan, for: self)?.max() else { return nil }
            return end
        }
    }
}
