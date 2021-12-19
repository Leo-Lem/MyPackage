//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

extension Calendar.Component: CaseIterable {
    public static var allCases: [Calendar.Component] {
        [
            .era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone
        ]
    }
}

//TODO: add a failsafe for non Int Calendar.Components
extension Date {
    public var calendar: Calendar { Calendar.current }
    public var asDateComponents: DateComponents {
        get { self.calendar.dateComponents(Set(Calendar.Component.allCases), from: self) }
        set { self = self.calendar.date(from: newValue) ?? self }
    }
    
    //MARK: method for setting date component(s) of a date to certain value(s)
    public mutating func setValue(_ value: Int, for component: Calendar.Component) {
        self.asDateComponents.setValue(value, for: component)
    }
    
    public mutating func setValue(_ values: [Int], for components: [Calendar.Component]) {
        for i in 0..<components.count {
            let component = components[i], value = values[i]
            self.asDateComponents.setValue(value, for: component)
        }
    }
    
    //non-mutating method returning a component-modified version of self (by setting values)
    public func getDateWithValueSet(_ value: Int, for component: Calendar.Component) -> Date {
        var dateComponents = self.asDateComponents
        
        dateComponents.setValue(value, for: component)
        
        return self.calendar.date(from: dateComponents) ?? self
    }
    
    public func getDateWithValueSet(_ values: [Int], for components: [Calendar.Component]) -> Date {
        var dateComponents = self.asDateComponents
        
        for i in 0..<components.count {
            let component = components[i], value = values[i]
            dateComponents.setValue(value, for: component)
        }
        
        return self.calendar.date(from: dateComponents) ?? self
    }
    
    
    //MARK: method for adding certain value(s) to date component(s) of a date
    public mutating func addToValue(_ value: Int, for component: Calendar.Component) {
        let oldValue = self.asDateComponents.value(for: component) ?? 0
        self.asDateComponents.setValue(oldValue + value, for: component)
    }
    
    public mutating func addToValue(_ values: [Int], for components: [Calendar.Component]) {
        for i in 0..<components.count {
            let component = components[i], value = values[i]
            let oldValue = self.asDateComponents.value(for: component) ?? 0
            self.asDateComponents.setValue(oldValue + value, for: component)
        }
    }
    
    //non-mutating method returning a component-modified version of self (by adding to current values)
    public func getDateWithValueAdded(_ value: Int, for component: Calendar.Component) -> Date {
        var dateComponents = self.asDateComponents
        
        let oldValue = dateComponents.value(for: component) ?? 0
        dateComponents.setValue(oldValue + value, for: component)
        
        return self.calendar.date(from: dateComponents) ?? self
    }
    
    public func getDateWithValueAdded(_ values: [Int], for components: [Calendar.Component]) -> Date {
        var dateComponents = self.asDateComponents
        
        for i in 0..<components.count {
            let component = components[i], value = values[i]
            let oldValue = dateComponents.value(for: component) ?? 0
            dateComponents.setValue(oldValue + value, for: component)
        }
        
        return self.calendar.date(from: dateComponents) ?? self
    }
    
    //MARK: Implementing distance method alternative to get the distance in other units
    public enum DistanceUnit {
        case second, minute, hour, day, week, month, year
    }
    
    public func distance(to other: Date, in unit: Date.DistanceUnit) -> Double {
        var distance: Double = self.distance(to: other)
        
        switch unit {
        case .second: break
        case .minute: distance /= 60
        case .hour: distance /= (60 * 60)
        case .day: distance /= (60 * 60 * 24)
        case .week: distance /= (60 * 60 * 24 * 7)
        case .month: distance /= (60 * 60 * 24 * 30.4)
        case .year: distance /= (60 * 60 * 24 * 365.25)
        }
        
        return distance
    }
 }
