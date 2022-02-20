//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

public extension FileManager {
    
    func save<T: Encodable>(
        _ object: T,
        file: String,
        encoder: JSONEncoder = JSONEncoder()
    ) throws {
        let url = Self.documentsDirectory.appendingPathComponent(file)
        
        let data: Data = try {
            do { return try encoder.encode(object) } catch { throw SavingError.encoding(file, error: error) }
        }()
        
        do { try data.write(to: url) } catch { throw SavingError.saving(file, error: error) }
    }
    
    enum SavingError: Error {
        case encoding(_ file: String, error: Error),
             saving(_ file: String, error: Error)
        
        var message: String {
            switch self {
            case .encoding(let file, let error): return "Failed to encode \(file):\n\(error)"
            case .saving(let file, let error): return "Failed to save \(file):\n\(error)"
            }
        }
    }
    
}
