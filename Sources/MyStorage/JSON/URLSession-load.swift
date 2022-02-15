//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

public extension URLSession {
    func load<T: Decodable>(
        _ url: String,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        guard let url = URL(string: url) else { throw LoadingError.url(url) }
        
        let data: Data = try await {
            do {
                return try await URLSession.shared.data(from: url).0
            } catch { throw LoadingError.fetching(url, error: error) }
        }()
        
        let decoded: T = try {
            do {
                return try decoder.decode(T.self, from: data)
            } catch { throw LoadingError.decoding(url, error: error) }
        }()
        
        return decoded
    }
    
    enum LoadingError: Error {
        case url(_ url: String),
             fetching(_ url: URL, error: Error),
             decoding(_ url: URL, error: Error)
        
        var message: String {
            switch self {
            case .url(let url): return "Bad URL: \(url)"
            case .fetching(let url, let error): return "Failed to fetch the data from \(url):\n\(error)"
            case .decoding(let url, let error): return "Failed to decode the data from \(url):\n\(error)"
            }
        }
    }
}
