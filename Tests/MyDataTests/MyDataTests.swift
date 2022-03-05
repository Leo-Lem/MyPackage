//
//  MyDataTests.swift
//  
//
//  Created by Leopold Lemmermann on 05.03.22.
//

import XCTest
@testable import MyData

class MyDataTests: XCTestCase {

    func testLoadingStringFromBundle() throws {
        let bundle = Bundle.module
        let string: String = try bundle.load("DecodableString.json")
        
        XCTAssertEqual(string, "The rain in Spain falls mainly on the Spaniards.",
                       "The string must match the content of DecodableString.json.")
    }
    
    func testLoadingDictFromBundle() throws {
        let bundle = Bundle.module
        let dict: [String: Int] = try bundle.load("DecodableDictionary.json")
        
        XCTAssertEqual(dict.count, 3,
                       "There should be three items decoded from DecodableDictionary.json.")
        XCTAssertEqual(dict["One"], 1,
                       "The dictionary should contain Int to String mappings.")
    }
    
    

}
