//
//  MySwiftUITests.swift
//  
//
//  Created by Leopold Lemmermann on 05.03.22.
//

import XCTest
@testable import MySwiftUI
import SwiftUI

class MySwiftUITests: XCTestCase {

    func testBindingOnChangeCallsFunction() {
        // given
        var bool = false
        
        func exampleFunctionToCall() {
            bool = true
        }
        
        var storedValue = ""
        
        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )
        
        let changedBinding = binding.onChange(exampleFunctionToCall)
        
        // when
        changedBinding.wrappedValue = "Test"
        
        // then
        XCTAssertTrue(bool,
                      "The onChange() function was not run.")
    }

}
