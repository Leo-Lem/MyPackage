//
//  XML.swift
//  
//
//  Created by Leopold Lemmermann on 03.03.22.
//

import Foundation



// MARK: - (XMLNode)

/// <#Description#>
public final class XMLNode {
    
    /// The tag of the given XML Node
    public let tag: String
    /// Text data that's inside the given XML Node.
    public var data: String
    /// The attributes of the given XML node.
    public var attributes: [String: String]
    /// The child nodes contained in the given XML node.
    public var childNodes: [XMLNode]
    
    /// <#Description#>
    /// - Parameters:
    ///   - tag: <#tag description#>
    ///   - data: <#data description#>
    ///   - attributes: <#attributes description#>
    ///   - childNodes: <#childNodes description#>
    public init(
        tag: String,
        data: String,
        attributes: [String: String],
        childNodes: [XMLNode]
    ) {
        self.tag = tag
        self.data = data
        self.attributes = attributes
        self.childNodes = childNodes
    }
    
}

public extension XMLNode {
    
    /// <#Description#>
    /// - Parameter name: <#name description#>
    /// - Returns: <#description#>
    func getAttribute(_ name: String) -> String? {
        attributes[name]
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - newValue: <#newValue description#>
    func setAttribute(
        _ name: String,
        newValue: String
    ) {
        attributes[name] = newValue
    }
    
    /// <#Description#>
    /// - Parameter name: <#name description#>
    /// - Returns: <#description#>
    func getElementsByTagName(_ name: String) -> [XMLNode] {
        var results = [XMLNode]()
        
        for node in childNodes {
            if node.tag == name {
                results.append(node)
            }
            
            results += node.getElementsByTagName(name)
        }
        
        return results
    }
    
}

extension XMLNode: CustomStringConvertible {
    
    /// <#Description#>
    public var description: String {
        generateXMLString()
    }
    
    private func generateXMLString(_ indent: Int = 0) -> String {
        var string = ""
        
        if indent == 0 { addHeader() }
        
        addIndentation()
        
        openTag()
        
        if childNodes.isEmpty {
            string.append(data)
        } else {
            string.append("\n")
            
            for node in childNodes {
                string.append(node.generateXMLString(indent + 1))
            }
            
            addIndentation()
        }
        
        closeTag()
        if indent > 0 { string.append("\n") }
        
        func addHeader() {
            string.append("<?xml")
            
            addAttribute(key: "version", value: "1.0")
            
            string.append("?>\n")
        }
        
        func openTag() {
            string.append("<\(tag)")
            
            for attribute in attributes {
                addAttribute(key: attribute.key, value: attribute.value)
            }
            
            string.append(">")
        }
        
        func closeTag() {
            string.append("</\(tag)>")
        }
        
        func addAttribute(key: String, value: String) {
            string.append(" \(key)=\"\(value)\"")
        }
        
        func addIndentation() {
            string.append(String(repeating: "\t", count: indent))
        }
        
        return string
    }
    
}



// MARK: - (MicroDOM)

/// <#Description#>
public final class MicroDOM: NSObject, XMLParserDelegate {
    
    private let parser: XMLParser
    private var stack = [XMLNode](),
                tree: XMLNode?
    
    /// <#Description#>
    /// - Parameter data: <#data description#>
    public init(data: Data) {
        parser = XMLParser(data: data)
        super.init()
        parser.delegate = self
    }
}

public extension MicroDOM {
    
    /// <#Description#>
    /// - Returns: <#description#>
    func parse() -> XMLNode? {
        parser.parse()
        
        guard parser.parserError == nil else { return nil }
        
        return tree
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - parser: <#parser description#>
    ///   - elementName: <#elementName description#>
    ///   - namespaceURI: <#namespaceURI description#>
    ///   - qName: <#qName description#>
    ///   - attributeDict: <#attributeDict description#>
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        let node = XMLNode(
            tag: elementName,
            data: "",
            attributes: attributeDict,
            childNodes: []
        )
        stack.append(node)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - parser: <#parser description#>
    ///   - elementName: <#elementName description#>
    ///   - namespaceURI: <#namespaceURI description#>
    ///   - qName: <#qName description#>
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        let lastElement = stack.removeLast()

        if let last = stack.last {
            last.childNodes += [lastElement]
        } else {
            tree = lastElement
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - parser: <#parser description#>
    ///   - string: <#string description#>
    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        stack.last?.data = string
    }
    
}
