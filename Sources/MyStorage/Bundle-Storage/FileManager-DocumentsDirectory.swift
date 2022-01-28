//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 22.12.21.
//

import Foundation

public extension FileManager {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
