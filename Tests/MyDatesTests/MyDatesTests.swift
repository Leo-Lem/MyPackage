//
//  MyDates-Tests.swift
//  
//
//  Created by Leopold Lemmermann on 27.01.22.
//

import XCTest
@testable import MyDates

class MyDatesTests: XCTestCase {
    private let calComps: Set<Calendar.Component> = [
        .nanosecond, .second, .minute, .hour, .day, .weekOfYear, .month, .quarter, .year
    ]
    
    private let otherCalComps: Set<Calendar.Component> = [
        .calendar, .timeZone, .era, .weekOfMonth, .weekday, .weekdayOrdinal, .yearForWeekOfYear
    ]
    
    //MARK: - time interval init with unit
    func testInitWithUnit() {
        let acc = 0.005
        
        XCTAssertEqual(
            TimeInterval(1, .nanosecond),
            1 / 1_000_000_000,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .second),
            1,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .minute),
            60,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .hour),
            60 * 60,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .day),
            60 * 60 * 24,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .weekOfYear),
            60 * 60 * 24 * 7,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .month),
            60 * 60 * 24 * 30.41,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .quarter),
            60 * 60 * 24 * 91.3125,
            accuracy: acc
        )
        
        XCTAssertEqual(
            TimeInterval(1, .year),
            60 * 60 * 24 * 365.25,
            accuracy: acc
        )
        
        otherCalComps.forEach { XCTAssertEqual(TimeInterval(1, $0), 1) }
    }
    
    //MARK: - converting time interval
    func testConverting() {
        let interval: TimeInterval = 60 * 60 * 24 * 365
        
        let acc = 0.005
        
        XCTAssertEqual(
            interval.convert(to: .nanosecond)!,
            60 * 60 * 24 * 365 * 1_000_000_000,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .second)!,
            60 * 60 * 24 * 365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .minute)!,
            60 * 24 * 365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .hour)!,
            24 * 365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .day)!,
            365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .weekOfYear)!,
            52.14,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .month)!,
            12,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .quarter)!,
            4,
            accuracy: acc
        )
        
        XCTAssertEqual(
            interval.convert(to: .year)!,
            1,
            accuracy: acc
        )
        
        otherCalComps.forEach { XCTAssertNil(interval.convert(to: $0)) }
    }
    
    //MARK: - distance calculation
    func testDistance() {
        let date = Date(),
            other = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365)
        
        let acc = 0.005
        
        XCTAssertEqual(
            date.distance(to: other, in: .nanosecond)!,
            60 * 60 * 24 * 365 * 1_000_000_000,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .second)!,
            60 * 60 * 24 * 365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .minute)!,
            60 * 24 * 365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .hour)!,
            24 * 365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .day)!,
            365,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .weekOfYear)!,
            52.14,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .month)!,
            12,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .quarter)!,
            4,
            accuracy: acc
        )
        
        XCTAssertEqual(
            date.distance(to: other, in: .year)!,
            1,
            accuracy: acc
        )
        
        otherCalComps.forEach { XCTAssertNil(date.distance(to:other, in: $0)) }
    }
    
    //MARK: - enumerating dates
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
    
    //MARK: - startof and endof
    
    
    //MARK: - striding over dates
    
    
}
