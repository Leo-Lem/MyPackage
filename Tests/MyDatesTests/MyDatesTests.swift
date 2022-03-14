//
//  MyDates-Tests.swift
//  
//
//  Created by Leopold Lemmermann on 27.01.22.
//

import XCTest
@testable import MyDates

class MyDatesTests: XCTestCase {
    
    private struct TestData {
        let comps: (compatible: Set<Calendar.Component>, incompatible: Set<Calendar.Component>) = (
            [.nanosecond, .second, .minute, .hour, .day, .weekOfYear, .month, .quarter, .year],
            [.calendar, .timeZone, .era, .weekday, .weekdayOrdinal, .weekOfMonth, .yearForWeekOfYear]
        )
        
        //an operand to convert from seconds into the respective other component
        let operand: [Calendar.Component: Double] = [
            .nanosecond: 1_000_000_000,
            .second: 1,
            .minute: 1 / 60,
            .hour: 1 / (60 * 60),
            .day: 1 / (60 * 60 * 24),
            .weekday: 1 / (60 * 60 * 24),
            .weekOfYear: 1 / (60 * 60 * 24 * 7),
            .weekOfMonth: 1 / (60 * 60 * 24 * 7),
            .month: 1 / (60 * 60 * 24 * 30.41),
            .quarter: 1 / (60 * 60 * 24 * 91.3125),
            .year: 1 / (60 * 60 * 24 * 365.25)
            
        ]
        
        let dates: (start: Date, end: Date) = (
            //17.7.2021, 13:02 (european time)
            Date(timeIntervalSinceReferenceDate: TimeInterval(valuesWithUnit: (20, .year), (6, .month), (15, .day))),
            //11.10.2021, 18:33 (european time)
            Date(timeIntervalSinceReferenceDate: TimeInterval(valuesWithUnit: (20, .year), (9, .month), (10, .day)))
        )
        
        let timeInterval: TimeInterval = 7450272
    }
    
    
    
    
    // MARK: - (time interval init with unit
    func testInitWithUnit() {
        let testData = TestData()
        let comps = testData.comps
        
        let acc = 0.005
        
        comps.compatible.forEach { comp in
            XCTAssertEqual(TimeInterval(1, comp), 1 / testData.operand[comp]!, accuracy: acc)
        }
        
        comps.incompatible.forEach { comp in XCTAssertEqual(TimeInterval(1, comp), 1) }
    }
    
    // MARK: - (converting time interval
    func testConverting() {
        let testData = TestData()
        let comps = testData.comps
        let interval = testData.timeInterval
        
        let acc = 0.005
        
        comps.compatible.forEach { comp in
            XCTAssertEqual(interval.convert(to: comp)!, interval * testData.operand[comp]!, accuracy: acc)
        }
        
        testData.comps.incompatible.forEach { comp in XCTAssertNil(interval.convert(to: comp)) }
    }
    
    // MARK: - (distance calculation
    func testDistance() {
        let testData = TestData()
        let comps = testData.comps
        let start = testData.dates.start,
            end = testData.dates.end,
            interval = testData.timeInterval
        
        let acc = 0.5
        
        comps.compatible.forEach { comp in
            XCTAssertEqual(start.distance(to: end, unit: comp)!, interval * testData.operand[comp]!, accuracy: acc)
        }
        
        
        comps.incompatible.forEach { comp in XCTAssertNil(start.distance(to: end, unit: comp)) }
    }
    
    // MARK: - (enumerating dates
    func testEnumerate() {
        let date = Date(timeIntervalSinceReferenceDate: 0)
        
        XCTAssertEqual(
            date.enumerate(in: .weekOfYear)?.count,
            7
        )
        
        XCTAssertEqual(
            date.enumerate(in: .month)?.count,
            31
        )
        
    }
    
    // MARK: - (startof and endof
    func testStartOf() {
        
    }
    
    // MARK: - (striding over dates
    
    
}
