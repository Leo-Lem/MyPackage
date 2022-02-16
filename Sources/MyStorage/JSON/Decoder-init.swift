//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

public extension JSONDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T {
        try self.decode(T.self, from: data)
    }
}
