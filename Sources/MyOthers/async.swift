//
//  async.swift
//  
//
//  Created by Leopold Lemmermann on 18.01.22.
//

import Foundation

//MARK: - Task
public extension Task where Success == Never, Failure == Never {
    
    /***/
    static func sleep(
        seconds: Double
    ) async throws {
        let duration = UInt64(seconds) * 1_000_000_000
        try await self.sleep(nanoseconds: duration)
    }
    
}

//MARK: - URLSession
public extension URLSession {
    
    /***/
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
    
}
