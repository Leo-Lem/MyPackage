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

//MARK: - HTML interpolation
public struct HTML: ExpressibleByStringInterpolation {
    
    ///
    private(set) public var content: String
    
    /***/
    public init(stringInterpolation: StringInterpolation) {
        content = stringInterpolation.html
    }
    
    /***/
    public init(stringLiteral value: String) {
        content = value
    }
    
}

public extension HTML {
    
    /***/
    struct StringInterpolation: StringInterpolationProtocol {
        
        ///
        private(set) public var html = ""
        
        /***/
        public init(literalCapacity: Int, interpolationCount: Int) {
            let estimatedSize = literalCapacity + interpolationCount * 16
            html.reserveCapacity(estimatedSize)
        }
        
        /***/
        public mutating func appendLiteral(_ literal: StringLiteralType) {
            html.append(literal)
        }
        
    }
    
}

public extension HTML.StringInterpolation {
    
    /***/
    private mutating func escapedAppend(_ content: String) {
        let replacements: [String: String] = ["&": "&amp", "<": "&lt", ">": "&gt", "\"": "&quot"]
        var replaced = content
        
        replacements.forEach { replacement in
            replaced = replaced.replacingOccurrences(of: replacement.key, with: replacement.value)
        }
        
        html.append(replaced)
    }
    
    /***/
    mutating func appendInterpolation(_ url: URL, content: String) {
        html.append("<a href=\"\(url.absoluteString)\">")
        escapedAppend(content)
        html.append("</a>")
    }
    
    /***/
    mutating func appendInterpolation(code: String) {
        if code.contains("\n") {
            html.append("<pre><code>")
            escapedAppend(code)
            html.append("</code></pre>")
        } else {
            html.append("<code>")
            escapedAppend(code)
            html.append("</code>")
        }
    }
    
    /***/
    mutating func appendInterpolation(_ date: Date, date dateStyle: Date.FormatStyle.DateStyle = .complete, time timeStyle: Date.FormatStyle.TimeStyle = .omitted) {
        html.append(date.formatted(date: dateStyle, time: timeStyle))
    }
    
}
