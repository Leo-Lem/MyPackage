//
//  File 2.swift
//  
//
//  Created by Leopold Lemmermann on 20.01.22.
//

import Foundation

//MARK: methods for modifying date components of a date
public extension Date {
    
    mutating func setting(_ values: [Int], for components: [Calendar.Component]) {
        for i in 0..<components.count {
            let component = components[i], value = values[i]
            self.asDateComponents.setValue(value, for: component)
        }
    }
    
    mutating func adding(_ values: [Int], to components: [Calendar.Component]) {
        for i in 0..<components.count {
            let component = components[i], value = values[i]
            let oldValue = self.asDateComponents.value(for: component) ?? 0
            self.asDateComponents.setValue(oldValue + value, for: component)
        }
    }
    
    func bySetting(_ values: [Int], for components: [Calendar.Component]) -> Date {
        var date = self
        date.setting(values, for: components)
        return date
    }
    
    func byAdding(_ values: [Int], to components: [Calendar.Component]) -> Date {
        var date = self
        date.adding(values, to: components)
        return date
    }
    
    //MARK: variadic parameters for the methods
    mutating func setting(_ values: Int..., for components: Calendar.Component...) { setting(values, for: components) }
    mutating func adding(_ values: Int..., to components: Calendar.Component...) { adding(values, to: components) }
    
    func bySetting(_ values: Int..., for components: Calendar.Component...) -> Date { bySetting(values, for: components) }
    func byAdding(_ values: Int..., to components: Calendar.Component...) -> Date { byAdding(values, to: components) }
    
}
