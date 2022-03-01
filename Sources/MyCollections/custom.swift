//
//  custom.swift
//  
//
//  Created by Leopold Lemmermann on 27.02.22.
//

import Foundation
import MyNumbers

//MARK: - Stack
/***/
public struct Stack<Element> {
    
    ///
    private var array = [Element]()
    
}

public extension Stack {
    
    /***/
    mutating func push(
        _ elements: Element...
    ) {
        array.append(contentsOf: elements)
    }
    
    /***/
    mutating func pop() -> Element? { array.popLast() }
    
    /***/
    mutating func removeAll() { array.removeAll() }
    
    /***/
    func peek() -> Element? { array.last }
    
    /***/
    func contains(
        where predicate: (Element) throws -> Bool
    ) rethrows -> Bool {
        try array.contains(where: predicate)
    }
    
    /***/
    func contains(
        _ element: Element
    ) -> Bool where Element: Equatable {
        array.contains(element)
    }
    
    ///
    var count: Int { array.count }
    
    ///
    var isEmpty: Bool { array.isEmpty }
    
}

extension Stack: ExpressibleByArrayLiteral {
    
    /***/
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
}

extension Stack: CustomDebugStringConvertible {
    
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
    
    /***/
    init(_ stack: Stack<Element>) {
        self.init()
        
        var stack = stack
        while let element = stack.pop() {
            self.append(element)
        }
    }
    
}

//MARK: - linked lists
/***/
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

//MARK: Doubly linked lists
/***/
public final class DoublyLinkedList<Element>: LinkedList<Element> {
    
    ///
    public var end: DoublyNode<Element>?
    
    /***/
    public required init(
        arrayLiteral elements: Element...
    ) {
        super.init(array: elements)
        
        for element in elements {
            end = DoublyNode(element, last: end)
        }
    }
    
    /***/
    public class DoublyNode<Element>: Node<Element> {
        
        ///
        public var last: DoublyNode?
        
        /***/
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

//MARK: - Queues and Deques
//MARK: Queues
/***/
public struct Queue<Element> {
    
    private var array = [Element]()
    
}

public extension Queue {
    
    ///
    var first: Element? { array.first }
    ///
    var last: Element? { array.last }
    
    /***/
    mutating func append(
        _ element: Element
    ) {
        array.append(element)
    }
    
    /***/
    mutating func dequeue() -> Element? {
        guard array.count > 0 else { return nil }
        return array.remove(at: 0)
    }
    
}

/***/
public protocol Prioritized {
    
    ///
    var priority: Int { get }
    
}

extension Queue where Element: Prioritized {
    
    /***/
    public mutating func dequeue() -> Element? {
        guard let max = array
                .enumerated()
                .max(by: { $0.element.priority < $1.element.priority })
        else { return nil }
        
        return array.remove(at: max.offset)
    }
    
}

extension Queue: Sequence {
    
    public func makeIterator() -> some IteratorProtocol { Iterator(items: self.array) }
    
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
    
    /***/
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
}

//MARK: Deques
/***/
public struct Deque<Element> {
    
    private var array = [Element]()
    
}

public extension Deque {
    
    ///
    var first: Element? { array.first }
    ///
    var last: Element? { array.last }
    
    /***/
    mutating func prepend(
        _ element: Element
    ) {
        array.prepend(element)
    }
    
    /***/
    mutating func append(
        _ element: Element
    ) {
        array.append(element)
    }
    
    /***/
    mutating func dequeueFront() -> Element? {
        guard array.count > 0 else { return nil }
        return array.remove(at: 0)
    }
    
    /***/
    mutating func dequeueBack() -> Element? {
        guard array.count > 0 else { return nil }
        return array.removeLast()
    }
    
    /***/
    func firstIndex(
        of element: Element
    ) -> Int? where Element: Equatable {
        array.firstIndex(of: element)
    }
    
    /***/
    func contains(
        _ element: Element
    ) -> Bool where Element: Equatable {
        array.contains(element)
    }
    
}

extension Deque: Sequence {
    
    public func makeIterator() -> some IteratorProtocol { Iterator(items: self.array) }
    
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
    
    /***/
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
}

//MARK: - Trees
//MARK: class implementation
/***/
public final class Node<Value> {
    
    ///
    public var value: Value
    ///
    public private(set) var children: [Node]
    ///
    weak var parent: Node?
    
    /***/
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
    
    /***/
    func add(child: Node) { children.append(child) }
    
    ///
    var count: Int { 1 + children.sum(\.count) }
    
    /***/
    convenience init(
        _ value: Value,
        parent: Node? = nil,
        @Builder builder: () -> [Node]
    ) {
        self.init(value, children: builder())
    }
    
    /***/
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
    
    /**
    Tries finding a specific root or child node by value.
     
     - parameter value: The value of the node to find.
     
     - returns: If it exists, the tree node with the specified `value`, otherwise nil.
     */
    func find(
        _ value: Value
    ) -> Node? {
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

/*
//MARK: struct implementation
/***/
public struct Node<Value> {
    
    ///
    public var value: Value
    ///
    public private(set) var children: [Node]
    
    /***/
    public init(_ value: Value, children: [Node] = []) {
        self.value = value
        self.children = children
    }
    
}

public extension Node {
    
    /***/
    mutating func add(child: Node) { children.append(child) }
    
    ///
    var count: Int { 1 + children.sum(\.count) }
    
    /***/
    init(
        _ value: Value,
        @Builder builder: () -> [Node]
    ) {
        self.init(value, children: builder())
    }
    
    /***/
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
    
    /**
    Tries finding a specific root or child node by value.
     
     - parameter value: The value of the node to find.
     
     - returns: If it exists, the tree node with the specified `value`, otherwise nil.
     */
    func find(
        _ value: Value
    ) -> Node? {
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

//MARK: Binary Trees
/***/
public final class BinaryNode<Value> {
    
    ///
    public var value: Value
    ///
    public var left: BinaryNode?,
               right: BinaryNode?
    
    /***/
    public init(
        _ value: Value
    ) {
        self.value = value
    }
    
}

public extension Array {
    
    init<T>(_ node: BinaryNode<T>) where Element == BinaryNode<T> {
        self.init()
        
        if let left = node.left { self += left }
        self += node
        if let right = node.right { self += right }
    }
    
}

extension BinaryNode: Sequence {
    
    public func makeIterator() -> some IteratorProtocol {
        Array(self).makeIterator()
    }
    
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


