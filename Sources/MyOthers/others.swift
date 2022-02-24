//
//  others.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation

//MARK: - undefined method for placeholders during development
/***/
public func undefined<T>(hint: String = "", file: StaticString = #file, line: UInt = #line) -> T {
    let message = hint == "" ? "" : ": \(hint)"
    fatalError("undefined \(T.self)\(message)", file:file, line:line)
}
