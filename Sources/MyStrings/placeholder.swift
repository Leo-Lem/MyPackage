//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

public extension String {
    static func placeholder(length: Int) -> String { String(repeating: "X", count: length) }
}
