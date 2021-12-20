//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

class JSONDataLoadingFromURL {
    private enum DataLoadingError: Error {
        case invalidURL, fetching(_ description: String?), decoding(_ description: String?)
    }
    
    private func getURL(from string: String) throws -> URL {
        if let url = URL(string: string) {
            return url
        } else {
            throw DataLoadingError.invalidURL
        }
    }
    
    private func fetch(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw DataLoadingError.fetching(error.localizedDescription)
        }
    }
    
    private func decode<T: Decodable>(_ data: Data, to type: T, decoder: JSONDecoder) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DataLoadingError.decoding(error.localizedDescription)
        }
    }
    
    //MARK: loading the data from a URL-string or a URL
    public func load<T: Decodable>(from urlString: String, to type: T, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let url = try getURL(from: urlString)
        let data = try await fetch(from: url)
        return try decode(data, to: type, decoder: decoder)
    }
    
    public func load<T: Decodable>(from url: URL, to type: T, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let data = try await fetch(from: url)
        return try decode(data, to: type, decoder: decoder)
    }
    
    //MARK: handling the errors
    public func loadHandled<T: Decodable>(from string: String, to type: T, decoder: JSONDecoder = JSONDecoder()) async -> T? {
        do {
            return try await load(from: string, to: type, decoder: decoder)
        } catch DataLoadingError.invalidURL {
            print("Invalid URL")
        } catch DataLoadingError.fetching(let description) {
            print("Fetching Error: \(description ?? "Unknown")")
        } catch DataLoadingError.decoding(let description) {
            print("Decoding Error: \(description ?? "Unknown")")
        } catch {
            print("Unknown Error")
        }
        return nil
    }
    
    public func loadHandled<T: Decodable>(from url: URL, to type: T, decoder: JSONDecoder = JSONDecoder()) async -> T? {
        do {
            return try await load(from: url, to: type, decoder: decoder)
        } catch DataLoadingError.invalidURL {
            print("Invalid URL")
        } catch DataLoadingError.fetching(let description) {
            print("Fetching Error: \(description ?? "Unknown")")
        } catch DataLoadingError.decoding(let description) {
            print("Decoding Error: \(description ?? "Unknown")")
        } catch {
            print("Unknown Error")
        }
        return nil
    }
}
