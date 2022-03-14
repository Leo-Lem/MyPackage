//
//  custom.swift
//  
//
//  Created by Leopold Lemmermann on 27.02.22.
//

import Foundation
import MyNumbers



// MARK: - (stack)

/// <#Description#>
public struct Stack<Element> {
    
    /// <#Description#>
    private var array = [Element]()
    
}

public extension Stack {
    
    /// <#Description#>
    /// - Parameter elements: <#elements description#>
    mutating func push(_ elements: Element...) { array.append(contentsOf: elements) }
    
    /// <#Description#>
    /// - Returns: <#description#>
    mutating func pop() -> Element? { array.popLast() }
    
    /// <#Description#>
    mutating func removeAll() { array.removeAll() }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func peek() -> Element? { array.last }
    
    /// <#Description#>
    /// - Parameter predicate: <#predicate description#>
    /// - Returns: <#description#>
    func contains(
        where predicate: (Element) throws -> Bool
    ) rethrows -> Bool {
        try array.contains(where: predicate)
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func contains(
        _ element: Element
    ) -> Bool where Element: Equatable {
        array.contains(element)
    }
    
    /// <#Description#>
    var count: Int { array.count }
    
    /// <#Description#>
    var isEmpty: Bool { array.isEmpty }
    
}

extension Stack: ExpressibleByArrayLiteral {
    
    /// <#Description#>
    /// - Parameter elements: <#elements description#>
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
}

extension Stack: CustomDebugStringConvertible {
    
    /// A textual representation of this Stack, suitable for debugging.
    public var debugDescription: String {
        var result = "["
        var first = true
        
        for item in array {
            first ? (first = false) : (result += ",")
            
            debugPrint(item, terminator: "", to: &result)
        }
        
        result += "]"
        return result
    }
    
}

extension Stack: Equatable where Element: Equatable {}
extension Stack: Hashable where Element: Hashable {}
extension Stack: Encodable where Element: Encodable {}
extension Stack: Decodable where Element: Decodable {}

public extension Array {
    
    /// <#Description#>
    /// - Parameter stack: <#stack description#>
    init(_ stack: Stack<Element>) {
        self.init()
        
        var stack = stack
        while let element = stack.pop() {
            self.append(element)
        }
    }
    
}



// MARK: - (linked lists)

// MARK: linked list

/// <#Description#>
public class LinkedList<Element>: ExpressibleByArrayLiteral {
    
    ///
    public var start: Node<Element>?
    
    public init(
        array elements: [Element]
    ) {
        for element in elements.reversed() {
            start = Node(element, next: start)
        }
    }
    
    public required init(
        arrayLiteral elements: Element...
    ) {
        for element in elements.reversed() {
            start = Node(element, next: start)
        }
    }
    
    ///
    public var count: Int {
        var count = 0, node = start
        
        while let next = node?.next {
            count++
            node = next
        }
        
        return count
    }
    
    /***/
    public class Node<Element> {
        
        ///
        public var value: Element,
                   ///
                   next: Node?
        
        /***/
        public init(
            _ value: Element,
            next: Node? = nil
        ) {
            self.value = value
            self.next = next
        }
        
    }
    
}

extension LinkedList: Sequence {
    
    public func makeIterator() -> some IteratorProtocol { Iterator(current: start) }
    
    struct Iterator<Element>: IteratorProtocol {
        var current: Node<Element>?
        
        public mutating func next() -> Node<Element>? {
            defer { current = current?.next }
            return current
        }
    }
    
}

// MARK: Doubly linked lists

/// <#Description#>
public final class DoublyLinkedList<Element>: LinkedList<Element> {
    
    /// <#Description#>
    public var end: DoublyNode<Element>?
    
    /// <#Description#>
    /// - Parameter elements: <#elements description#>
    public required init(arrayLiteral elements: Element...) {
        super.init(array: elements)
        
        for element in elements {
            end = DoublyNode(element, last: end)
        }
    }
    
    /// <#Description#>
    public class DoublyNode<Element>: Node<Element> {
        
        /// <#Description#>
        public var last: DoublyNode?
        
        /// <#Description#>
        /// - Parameters:
        ///   - value: <#value description#>
        ///   - next: <#next description#>
        ///   - last: <#last description#>
        public init(
                _ value: Element,
                next: DoublyNode? = nil,
                last: DoublyNode? = nil
        ) {
            super.init(value, next: next)
            self.last = last
        }
        
    }
}



// MARK: - (Queues and Deques)

// MARK: Queues

/// <#Description#>
public struct Queue<Element> {
    
    /// <#Description#>
    private var array = [Element]()
    
}

public extension Queue {
    
    /// <#Description#>
    var first: Element? { array.first }
    
    /// <#Description#>
    var last: Element? { array.last }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    mutating func append(_ element: Element) {
        array.append(element)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    mutating func dequeue() -> Element? {
        guard array.count > 0 else { return nil }
        return array.remove(at: 0)
    }
    
}

/// <#Description#>
public protocol Prioritized {
    
    /// <#Description#>
    var priority: Int { get }
    
}

extension Queue where Element: Prioritized {
    
    /// <#Description#>
    /// - Returns: <#description#>
    public mutating func dequeue() -> Element? {
        guard let max = array
                .enumerated()
                .max(by: { $0.element.priority < $1.element.priority })
        else { return nil }
        
        return array.remove(at: max.offset)
    }
    
}

extension Queue: Sequence {
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func makeIterator() -> some IteratorProtocol { Iterator(items: self.array) }
    
    /// <#Description#>
    public struct Iterator<Element>: IteratorProtocol {
        public let items: [Element]
        private(set) var position = 0
        
        public mutating func next() -> Element? {
            if position < items.count {
                defer { position++ }
                return items[position]
            } else { return nil }
        }
    }
    
}

extension Queue: ExpressibleByArrayLiteral {
    
    /// <#Description#>
    /// - Parameter elements: <#elements description#>
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
}

// MARK: Deques

/// <#Description#>
public struct Deque<Element> {
    
    /// <#Description#>
    private var array = [Element]()
    
}

public extension Deque {
    
    /// <#Description#>
    var first: Element? { array.first }
    
    /// <#Description#>
    var last: Element? { array.last }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    mutating func prepend(_ element: Element) {
        array.prepend(element)
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    mutating func append(_ element: Element) {
        array.append(element)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    mutating func dequeueFront() -> Element? {
        guard array.count > 0 else { return nil }
        return array.remove(at: 0)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    mutating func dequeueBack() -> Element? {
        guard array.count > 0 else { return nil }
        return array.removeLast()
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func firstIndex(of element: Element) -> Int? where Element: Equatable {
        array.firstIndex(of: element)
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func contains(_ element: Element) -> Bool where Element: Equatable {
        array.contains(element)
    }
    
}

extension Deque: Sequence {
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func makeIterator() -> some IteratorProtocol { Iterator(items: self.array) }
    
    /// <#Description#>
    public struct Iterator<Element>: IteratorProtocol {
        public let items: [Element]
        private(set) var position = 0
        
        public mutating func next() -> Element? {
            if position < items.count {
                defer { position++ }
                return items[position]
            } else { return nil }
        }
    }
    
}

extension Deque: ExpressibleByArrayLiteral {
    
    
    /// <#Description#>
    /// - Parameter elements: <#elements description#>
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
}



// MARK: - (Trees)

// MARK: class implementation

/// <#Description#>
public final class Node<Value> {
    
    /// <#Description#>
    public var value: Value
    
    /// <#Description#>
    public private(set) var children: [Node]
    
    /// <#Description#>
    weak var parent: Node?
    
    /// <#Description#>
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - parent: <#parent description#>
    ///   - children: <#children description#>
    public init(
        _ value: Value,
        parent: Node? = nil,
        children: [Node] = []
    ) {
        self.value = value
        self.parent = parent
        self.children = children
    }
    
}

public extension Node {
    
    /// <#Description#>
    /// - Parameter child: <#child description#>
    func add(child: Node) { children.append(child) }
    
    /// <#Description#>
    var count: Int { 1 + children.sum(\.count) }
    
    /// <#Description#>
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - parent: <#parent description#>
    ///   - builder: <#builder description#>
    convenience init(
        _ value: Value,
        parent: Node? = nil,
        @Builder builder: () -> [Node]
    ) {
        self.init(value, children: builder())
    }
    
    /// <#Description#>
    @resultBuilder
    struct Builder {
        static func buildBlock<Value>(
            _ children: Node<Value>...
        ) -> [Node<Value>] {
            children
        }
    }
    
}

public extension Node where Value: Equatable {
    
    /// Tries finding a specific root or child node by value.
    /// - Parameter value: The value of the node to find.
    /// - Returns: If it exists, the tree node with the specified `value`, otherwise nil.
    func find(_ value: Value) -> Node? {
        if self.value == value { return self }
        
        for child in children {
            if let match = child.find(value) { return match }
        }
        
        return nil
    }
    
}

extension Node: Equatable where Value: Equatable {
    public static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}

extension Node: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}

extension Node: Comparable where Value: Comparable {
    public static func < (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: struct implementation
/*
public struct Node<Value> {
    
    public var value: Value
    public private(set) var children: [Node]
    
    public init(_ value: Value, children: [Node] = []) {
        self.value = value
        self.children = children
    }
    
}

public extension Node {
    
    mutating func add(child: Node) { children.append(child) }
    
    var count: Int { 1 + children.sum(\.count) }
    
    init(
        _ value: Value,
        @Builder builder: () -> [Node]
    ) {
        self.init(value, children: builder())
    }
    
    @resultBuilder
    struct Builder {
        static func buildBlock<Value>(
            _ children: Node<Value>...
        ) -> [Node<Value>] {
            children
        }
    }
    
}

public extension Node where Value: Equatable {
    
    /// Tries finding a specific root or child node by value.
    /// - Parameter value: The value of the node to find.
    /// - Returns: If it exists, the tree node with the specified `value`, otherwise nil.
    func find(_ value: Value) -> Node? {
        if self.value == value { return self }
        
        for child in children {
            if let match = child.find(value) { return match }
        }
        
        return nil
    }
    
}

extension Node: Equatable where Value: Equatable {}
extension Node: Hashable where Value: Hashable {}
extension Node: Codable where Value: Codable {}
extension Node: Comparable where Value: Comparable {
    public static func < (lhs: Node<Value>, rhs: Node<Value>) -> Bool { lhs.value < rhs.value }
}
*/

// MARK: binary trees

/// <#Description#>
public final class BinaryNode<Value> {
    
    /// <#Description#>
    public var value: Value
    
    /// <#Description#>
    public var left: BinaryNode?,
               right: BinaryNode?
    
    /// <#Description#>
    /// - Parameter value: <#value description#>
    public init(_ value: Value) {
        self.value = value
    }
    
}

public extension Array {
    
    /// <#Description#>
    init<T>(_ node: BinaryNode<T>) where Element == BinaryNode<T> {
        self.init()
        
        if let left = node.left { self += left }
        self += node
        if let right = node.right { self += right }
    }
    
}

extension BinaryNode: Sequence {
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func makeIterator() -> some IteratorProtocol { Array(self).makeIterator() }
    
    /// <#Description#>
    struct Iterator<Value>: IteratorProtocol {
        var items: [Node<Value>]
        var position = 0

        mutating func next() -> Node<Value>? {
            if position < items.count {
                defer { position += 1 }
                return items[position]
            } else {
                return nil
            }
        }
    }
    
}



// MARK: - (counted set)

/// A Swift implementation of a counted set. Keeps count of added duplicates, rather than just discarding them.
public struct CountedSet<Element: Hashable> {
    
    private var elements: [Element: Int] = .init()
    
}

public extension CountedSet {
    
    /// The number of different elements in the set.
    var count: Int { elements.count }
    
    /// Indicates whether there are no elements in the set.
    var isEmpty: Bool { elements.isEmpty }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    mutating func insert(_ element: Element) {
        elements[element, default: 0] += 1
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    mutating func remove(_ element: Element) {
        if elements[element, default: 0] > 0 {
            elements[element, default: 0] -= 1
        }
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func count(for element: Element) -> Int? { elements[element] }
    
}

extension CountedSet: Sequence {
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func makeIterator() -> some IteratorProtocol { elements.makeIterator() }
    
}
