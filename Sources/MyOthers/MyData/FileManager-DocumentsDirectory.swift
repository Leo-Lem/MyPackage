//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 22.12.21.
//

import Foundation

extension FileManager {
    public static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
