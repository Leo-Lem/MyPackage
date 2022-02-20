//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 25.01.22.
//

import Foundation

//MARK: other methods
public extension Array {
    func byDropping(at index: Int) -> Self {
        var array = self
        array.remove(at: index)
        return array
    }
    
    func byInserting(_ element: Element, at index: Int) -> Self {
        var array = self
        array.insert(element, at: index)
        return array
    }
}
