//
//  JSON.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
import CoreLocation
import MyOthers

//MARK: - Decoder methods with type inferrence
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

//MARK: - URLSession load method with type inferrence
public extension URLSession {
    
    /***/
    func load<T: Decodable>(
        _ type: T.Type = T.self,
        _ url: URL,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
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
    
    /***/
    func load<T: Decodable>(
        _ type: T.Type = T.self,
        _ urlString: String,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        guard let url = URL(string: urlString) else { throw LoadingError.url(urlString) }
        
        return try await load(type, url, decoder: decoder)
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

//MARK: - JSON file struct
/***/
public struct JSONFile: FileDocument {
    public static var readableContentTypes = [UTType.json]
    public var data: Data
    
    public init(_ data: Data = Data()) { self.data = data }
    public init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents { self.data = data }
        else { throw CocoaError(.fileReadCorruptFile) }
    }
    
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: self.data)
    }
}

//MARK: - Codable extensions
extension CLLocationCoordinate2D: Codable {
    
    private enum CodingKeys: CodingKey {
        case longitude, latitude
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(longitude, forKey: .longitude)
            try container.encode(latitude, forKey: .latitude)
        } catch {
            print("#####Encoding coordinates failed: \(error)")
        }
    }
    
    public init(from decoder: Decoder) throws {
        self.init()
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
            self.latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        } catch {
            print("#####Decoding coordinates failed:\n\(error)")
        }
    }
    
}

//MARK: - custom JSON
/***/
@dynamicMemberLookup
public struct JSON {
    
    /// The optional value of any kind.
    public var value: Any?
    /// A date format defaulting to ISO8601
    public var dateFormat: String
    
    /***/
    public init(
        _ value: Any? = nil,
        dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) {
        self.value = value
        self.dateFormat = dateFormat
    }
    
    /***/
    public init(
        data: Data,
        options: JSONSerialization.ReadingOptions = [],
        dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) throws {
        value = try JSONSerialization.jsonObject(with: data, options: options)
        self.dateFormat = dateFormat
    }
    
    /***/
    public init(
        string: String,
        options: JSONSerialization.ReadingOptions = [],
        dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) throws {
        try self.init(
            data: Data(string.utf8),
            options: options,
            dateFormat: dateFormat
        )
    }
    
}

public extension JSON {
    
    /**
     Transforms the value to some generic type T, which can be inferred or explicitly specified.
     */
    func typed<T>(
        to type: T.Type = T.self
    ) -> T? {
        switch value {
        case let array as [Any] where T.self == [JSON].self:
            return array.map { JSON($0) } as? T
            
        case let dict as [String: Any] where T.self == [String: JSON].self:
            return dict.mapValues { JSON($0) } as? T
            
        case let string as String where T.self == Date.self:
            let formatter = DateFormatter()
            formatter.dateFormat = self.dateFormat
            return formatter.date(from: string) as? T
            
        default:
            return value as? T
        }
    }
    
    /**
     Adds a default value to the T-typed value. Constrained to types that are initializable without parameters.
     */
    func defaulted<T>(
        to type: T.Type = T.self
    ) -> T where T: Initializable {
        typed() ?? T()
    }
    
}

public extension JSON {
    
    /// Works if the JSON value is an array. Returns the element for the given index from said array.
    subscript(index: Int) -> JSON {
        get { typed(to: [JSON].self)?[index] ?? JSON(nil) }
        set {
            guard var array: [JSON] = typed() else { return }
            array[index] = newValue
            self.value = array
        }
    }
    
    /// Works if the JSON value is a dictionary. Returns the element for the key from said dictionary.
    subscript(key: String) -> JSON {
        get { typed(to: [String: JSON].self)?[key] ?? JSON(nil) }
        set {
            guard var dict: [String: JSON] = typed() else { return }
            dict[key] = newValue
            self.value = dict
        }
    }
    
    /// Variant which makes dynamic member lookup possible
    subscript(dynamicMember key: String) -> JSON {
        get { typed(to: [String: JSON].self)?[key] ?? JSON(nil) }
        set {
            guard var dict: [String: JSON] = typed() else { return }
            dict[key] = newValue
            self.value = dict
        }
    }
    
}

extension JSON: RandomAccessCollection {
    
    public var startIndex: Int { defaulted(to: [JSON].self).startIndex }
    public var endIndex: Int { defaulted(to: [JSON].self).endIndex }
    
}

extension JSON: ExpressibleByStringLiteral,
                ExpressibleByFloatLiteral,
                ExpressibleByNilLiteral,
                ExpressibleByBooleanLiteral,
                ExpressibleByIntegerLiteral,
                ExpressibleByArrayLiteral,
                ExpressibleByDictionaryLiteral {
    
    public init(stringLiteral value: StringLiteralType) { self.init(value) }
    public init(nilLiteral: ()) { self.init(nil) }
    public init(floatLiteral value: FloatLiteralType) { self.init(value) }
    public init(booleanLiteral value: BooleanLiteralType) { self.init(value) }
    public init(integerLiteral value: IntegerLiteralType) { self.init(value) }
    public init(arrayLiteral elements: JSON...) { self.init(elements) }
    public init(dictionaryLiteral elements: (String, JSON)...) { self.init(elements) }
    
}

extension JSON: CustomStringConvertible {
    
    public var description: String {
        guard let value = value else { return "nil" }
        return "\(value)"
    }
    
}
