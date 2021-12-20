//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

public class URLJSONLoader<T: Decodable> {
    public let urlString: String, decoder: JSONDecoder, type: T
    private var url: URL? { URL(string: urlString) }
    
    public init(loadFrom urlString: String, decoder: JSONDecoder = JSONDecoder(), type: T) {
        self.urlString = urlString
        self.decoder = decoder
        self.type = type
    }
    
    private enum DataLoadingError: Error {
        case fetching(_ description: String?), decoding(_ description: String?)
    }
    
    //MARK: loading the data from a URL-string and handling the errors
    public func load() async -> T? {
        do {
            let data = try await fetch()
            return try decode(data)
        } catch DataLoadingError.fetching(let description) {
            print("Fetching Error: \(description ?? "Unknown")")
        } catch DataLoadingError.decoding(let description) {
            print("Decoding Error: \(description ?? "Unknown")")
        } catch {
            print("Unknown Error")
        }
        return nil
    }
    
    //MARK: fetching and decoding the data
    private func fetch() async throws -> Data {
        do {
            let data = try await URLSession.shared.data(from: self.url!).0
            return data
        } catch {
            throw DataLoadingError.fetching(error.localizedDescription)
        }
    }
    
    private func decode(_ data: Data) throws -> T {
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw DataLoadingError.decoding(error.localizedDescription)
        }
    }
}
