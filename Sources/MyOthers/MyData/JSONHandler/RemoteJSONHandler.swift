//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

public class RemoteJSONHandler<T: Codable>: BundleJSONHandler<T> {
    public init(rawURL: String,
                decoder: JSONDecoder = JSONDecoder(),
                encoder: JSONEncoder = JSONEncoder()) {
        super.init(filename: rawURL, decoder: decoder, encoder: encoder)
    }
    
    //MARK: loading json data from remote location
    public func load() async throws -> T? {
        let url = try getURL()
        let data = try await fetch(from: url)
        let decoded = try decode(data)
        
        return decoded
    }
    
    override func getURL() throws -> URL {
        guard let url = URL(string: file) else {
            throw LoadingError.url("#####Bad URL: \(file)")
        }
        
        return url
    }
    
    func fetch(from url: URL) async throws -> Data {
        do {
            let data = try await URLSession.shared.data(from: url).0
            return data
        } catch {
            throw LoadingError.fetching("#####Fetching the data from \(url) failed:\n\(error)")
        }
    }
    
    //TODO: pushing data to remote location
}
