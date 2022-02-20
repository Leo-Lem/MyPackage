//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

public extension FileManager {
    func load<T: Decodable>(
        _ file: String,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        let url = Self.documentsDirectory.appendingPathComponent(file)
        
        let data: Data = try {
            do { return try Data(contentsOf: url) } catch { throw LoadingError.fetching(file, error: error) }
        }()
        
        let decoded: T = try {
            do { return try decoder.decode(T.self, from: data) } catch { throw LoadingError.decoding(file, error: error) }
        }()
        
        return decoded
    }
    
    enum LoadingError: Error {
        case fetching(_ file: String, error: Error),
             decoding(_ file: String, error: Error)
        
        var message: String {
            switch self {
            case .fetching(let file, let error): return "Failed to load \(file):\n\(error)"
            case .decoding(let file, let error): return "Failed to decode \(file):\n\(error)"
            }
        }
    }
    
}
