//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 02.01.22.
//

import Foundation

public class BundleJSONHandler<T: Codable> {
    let file: String,
        encoder: JSONEncoder,
        decoder: JSONDecoder
    
    public init(filename: String,
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.file = filename
        self.decoder = decoder
        self.encoder = encoder
    }
    
    //MARK: for handling errors during loading
    public enum LoadingError: Error {
        case url(_ description: String?),
             fetching(_ description: String?),
             decoding(_ description: String?)
    }
    
    //MARK: loading data from json file in bundle
    public func load() throws -> T {
        let url = try getURL()
        let data = try fetch(from: url)
        let decoded = try decode(data)
        
        return decoded
    }
    
    func getURL() throws -> URL {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            throw LoadingError.url("#####Couldn't find \(file) in main bundle...")
        }
        
        return url
    }
    
    func fetch(from url: URL) throws -> Data {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw LoadingError.fetching("#####Couldn't load \(file) from main bundle:\n\(error)")
        }
    }
    
    func decode(_ data: Data) throws -> T {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw LoadingError.decoding("#####Couldnt't parse \(file) as \(T.self):\n\(error)")
        }
    }
}
