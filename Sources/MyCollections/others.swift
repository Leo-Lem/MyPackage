//
//  others.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation



// MARK: - (Collections)

public extension Collection where Index == Int {
    
    /// <#Description#>
    @inlinable var lastIndex: Int { self.endIndex - 1 }
    
}



// MARK: - (range mutable bounds extension)

public extension ClosedRange {
    
    /// <#Description#>
    var mutableLowerBound: Bound {
        get { lowerBound }
        set { self = newValue...upperBound }
    }
    
    /// <#Description#>
    var mutableUpperBound: Bound {
        get { upperBound }
        set { self = lowerBound...newValue }
    }
    
}

public extension Range {
    
    /// <#Description#>
    var mutableLowerBound: Bound {
        get { lowerBound }
        set { self = newValue..<upperBound }
    }
    
    /// <#Description#>
    var mutableUpperBound: Bound {
        get { upperBound }
        set { self = lowerBound..<newValue }
    }
    
}



// MARK: - (init with generator)

public extension Array {
    
    /// <#Description#>
    /// - Parameters:
    ///   - count: <#count description#>
    ///   - generateElement: <#generateElement description#>
    init(count: Int, _ generateElement: (Int) -> Element) {
        var array = [Element]()
        for i in 0..<count {
            array.append(generateElement(i))
        }
        self = array
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - count: <#count description#>
    ///   - generateElement: <#generateElement description#>
    init(count: Int, _ generateElement: @autoclosure () -> Element) {
        var array = [Element]()
        for _ in 0..<count {
            array.append(generateElement())
        }
        self = array
    }
    
}



// MARK: - (box)

/// <#Description#>
public final class Box<Type> {
    
    /// <#Description#>
    var value: Type
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    init(_ value: Type) { self.value = value }
    
}

extension Box {
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func map<Other>(_ type: Other.Type = Other.self) -> Box<Other>? {
        guard let other = value as? Other else { return nil }
        return Box<Other>(other)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func map<Other>(_ transform: (Type) throws -> Other) rethrows -> Box<Other> {
        Box<Other>(try transform(value))
    }
    
}

extension Box: CustomStringConvertible where Type: CustomStringConvertible {
    public var description: String { value.description }
}

extension Box: Equatable where Type: Equatable {
    public static func == (lhs: Box, rhs: Box) -> Bool { lhs.value == rhs.value }
}

extension Box: Comparable where Type: Comparable {
    public static func < (lhs: Box, rhs: Box) -> Bool { lhs.value < rhs.value }
}

extension Box: Hashable where Type: Hashable {
    public func hash(into hasher: inout Hasher) { hasher.combine(value) }
}

extension Box: Identifiable where Type: Identifiable {
    public var id: Type.ID { value.id }
}

extension Box: Codable where Type: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Type.self)
        self.init(value)
    }
}
