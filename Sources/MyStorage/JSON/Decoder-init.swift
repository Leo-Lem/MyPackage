//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

public extension JSONDecoder {
    /**
     Decodes a top-level value of inferred type from the given JSON representation.
     
     - parameter data: The data to decode from.
     - returns: A value of inferred type.
     - throws:
        - `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid JSON.
        - An error if any value throws an error during decoding.
     */
    func decode<T: Decodable>(_ data: Data) throws -> T { try self.decode(T.self, from: data) }
}

public extension KeyedDecodingContainer {
    /**
     Decodes a value of inferred type for the given key.
     
     - parameter key: The key that the decoded value is associated with.
     - returns: A value of inferred type, if present for the given key and convertible to the inferred type.
     - throws:
        - `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the inferred type.
        - `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
        - `DecodingError.valueNotFound` if `self` has a null entry for the given key.
     */
    func decode<T: Decodable>(_ key: Key) throws -> T { try self.decode(T.self, forKey: key) }
    
    /**
     Decodes a value of the given type for the given key, if present.
     
     This method returns `nil` if the container does not have a value associated with `key`, or if the value is null. The difference between these states can be distinguished with a `contains(_:)` call.
     
     - parameter key: The key that the decoded value is associated with.
     - returns: A decoded value of  inferred type, or `nil` if the `Decoder` does not have an entry associated with the given key, or if the value is a null value.
     - throws: `DecodingError.typeMismatch` if the encountered encoded value is not convertible to the inferred type.
     */
    func decodeIfPresent<T: Decodable>(_ key: Key) throws -> T? { try self.decodeIfPresent(T.self, forKey: key) }
}
