//
//  interpolation.swift
//  
//
//  Created by Leopold Lemmermann on 25.02.22.
//

import Foundation
import MyCollections

public extension String.StringInterpolation {
    
    /***/
    mutating func appendInterpolation<T: Encodable & AnyObject>(_ value: T) {
        let encoder = JSONEncoder()
        
        if let result = try? encoder.encode(value) {
            let str = String(decoding: result, as: UTF8.self)
            appendLiteral(str)
        }
    }
    
    /***/
    mutating func appendInterpolation(_ url: URL, html: Bool = false) {
        let contents = try? String(contentsOf: url),
            lines = contents?.split(separator: "\n")[0..<10].joined(separator: "\n")
        
        
        appendLiteral(url.absoluteString + "\n")
        if html { appendLiteral(lines ?? "<Unavailable>") }
    }
    
    //MARK: - formatting collections of integers
    /***/
    enum CollectionFormatStyle<C: Collection> where C.Element == Int {
        case elements, sum, average
        
        func format(_ collection: C) -> String {
            switch self {
            case .elements: return collection.formatted(.list(memberStyle: .number, type: .and))
            case .sum: return collection.sum().formatted()
            case .average: return collection.average().formatted()
            }
        }
    }
    
    /***/
    mutating func appendInterpolation<C: Collection>(_ collection: C, style: CollectionFormatStyle<C>) where C.Element == Int {
        appendLiteral(style.format(collection))
    }
}
