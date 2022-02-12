//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 06.02.22.
//

import Foundation

public extension Collection where Index == Int {
    var lastIndex: Int { self.endIndex - 1 }
}
