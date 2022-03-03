//
//  FileManager.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

//MARK: - documents directory shortcut
public extension FileManager {
    
    ///
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}

//MARK: - loading and saving
public extension FileManager {
    
    /***/
    func load<T: Decodable>(
        _ type: T.Type = T.self,
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
    
    /***/
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
    
    /***/
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
    
    /***/
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


