//
//  others.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import Foundation

//MARK: - undefined method for placeholders during development
/***/
public func undefined<T>(
    hint: String = "",
    file: StaticString = #file,
    line: UInt = #line
) -> T {
    let message = hint == "" ? "" : ": \(hint)"
    fatalError("undefined \(T.self)\(message)", file: file, line: line)
}

//MARK: - AnyEquatable
/***/
public struct AnyEquatable {
    
    public var item: Any
    private let equals: (Self) -> Bool
    
    public init<T: Equatable>(_ item: T) {
        self.item = item
        
        self.equals = { item == ($0.item as? T) }
    }
    
}

extension AnyEquatable: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool { lhs.equals(rhs) }
    public static func == <Other: Equatable>(lhs: Self, rhs: Other) -> Bool { (lhs.item as? Other) == rhs }
    public static func == <Other: Equatable>(lhs: Other, rhs: Self) -> Bool { lhs == (rhs.item as? Other) }
    
}

//MARK: - AnyComparable
/***/
public struct AnyComparable {
    
    public var item: Any
    private let equals: (Self) -> Bool,
                less: (Self) -> Bool
    
    public init<T: Comparable>(_ item: T) {
        self.item = item
        
        self.equals = {
            item == $0.item as? T
        }
        
        self.less = {
            guard let other = ($0.item as? T) else { return false }
            return item < other
        }
    }
    
}

extension AnyComparable: Comparable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool { lhs.equals(rhs) }
    public static func == <Other: Equatable>(lhs: Self, rhs: Other) -> Bool { (lhs.item as? Other) == rhs }
    public static func == <Other: Equatable>(lhs: Other, rhs: Self) -> Bool { lhs == (rhs.item as? Other) }
    
    public static func < (lhs: Self, rhs: Self) -> Bool { lhs.less(rhs) }
    public static func < <Other: Comparable>(lhs: Self, rhs: Other) -> Bool {
        guard let lhs = (lhs.item as? Other) else { return false }
        return lhs < rhs
    }
    public static func < <Other: Comparable>(lhs: Other, rhs: Self) -> Bool {
        guard let rhs = (rhs.item as? Other) else { return false }
        return lhs < rhs
    }
    
}

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

//MARK: - Intializable procotol
/// Types which have an initializer without parameters can conform.
public protocol Initializable { init() }

extension Bool: Initializable {}
extension Float: Initializable {}
extension Double: Initializable {}
extension Int: Initializable {}
extension String: Initializable {}
extension Array: Initializable {}
extension Dictionary: Initializable {}
extension Date: Initializable {}
