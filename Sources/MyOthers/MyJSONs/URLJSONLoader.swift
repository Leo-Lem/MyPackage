//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

public class URLJSONLoader<T: Decodable> {
    public let urlString: String, decoder: JSONDecoder
    private var url: URL? { URL(string: urlString) }
    
    public init(urlString: String, decoder: JSONDecoder = JSONDecoder()) {
        self.urlString = urlString
        self.decoder = decoder
    }
    
    public enum LoadingError: Error {
        case url(_ description: String?), fetching(_ description: String?), decoding(_ description: String?)
    }
    
    //MARK: loading the data from a URL-string
    public func load() async throws -> T? {
        let data = try await fetch()
        return try decode(data)
    }
    
    //MARK: fetching and decoding the data
    private func fetch() async throws -> Data {
        do {
            guard let url = self.url else {
                throw LoadingError.url("Bad URL: \(urlString)")
            }
            let data = try await URLSession.shared.data(from: url).0
            return data
        } catch {
            throw LoadingError.fetching(error.localizedDescription)
        }
    }
    
    private func decode(_ data: Data) throws -> T {
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw LoadingError.decoding(error.localizedDescription)
        }
    }
}
