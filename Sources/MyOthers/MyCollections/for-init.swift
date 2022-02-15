//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import Foundation

public extension Array {
    init(count: Int, _ generateElement: (Int) -> Element) {
        var array = [Element]()
        for i in 0..<count {
            array.append(generateElement(i))
        }
        self = array
    }
    
    init(count: Int, _ generateElement: () -> Element) {
        var array = [Element]()
        for _ in 0..<count {
            array.append(generateElement())
        }
        self = array
    }
}
