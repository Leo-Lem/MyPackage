//
//  MyCollectionsTests.swift
//  
//
//  Created by Leopold Lemmermann on 05.03.22.
//

import XCTest
@testable import MyCollections

class MyCollectionsTests: XCTestCase {

    func testSequenceKeypathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sorted = items.sorted(by: \.self)
        XCTAssertEqual(sorted, [1, 2, 3, 4, 5],
                       "The sorted numbers must be ascending.")
    }

    func testSequenceKeyPathSortingCustom() {
        struct Example: Equatable { let value: String }

        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")
        let array = [example1, example2, example3]

        let sortedItems = array.sorted(by: \.value) {
            $0 > $1
        }

        XCTAssertEqual(sortedItems, [example3, example2, example1],
                       "Reverse sorting should yield c, b, a.")
    }
    
}
