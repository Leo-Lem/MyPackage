//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

//MARK: Methods to set and add to values (date components) of a Date().
extension Date {
    public func setValues(_ values: [Int], for components: Array<Calendar.Component>) -> Date {
        var comps = Calendar.current.dateComponents(Set(components), from: self)
        for i in 0..<components.count {
            comps.setValue(values[i], for: components[i])
        }
        return Calendar.current.date(from: comps) ?? Date()
    }
    
    public func addToValues(_ values: [Int], for components: Array<Calendar.Component>) -> Date {
        var comps = Calendar.current.dateComponents(Set(components), from: self)
        for i in 0..<components.count { comps.setValue((comps.value(for: components[i]) ?? 0)+values[i], for: components[i]) }
        return Calendar.current.date(from: comps) ?? Date()
    }
 }
