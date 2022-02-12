//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 28.01.22.
//

import Foundation

public extension Date {
    func endOf(_ comp: Calendar.Component, cal: Calendar = .current) -> Date? {
        guard
            let start = startOf(comp, cal: cal),
            let next = cal.date(byAdding: comp, value: 1, to: start)
        else { return nil }
        
        return next - 1
    }
}
