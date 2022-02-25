//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//


import SwiftUI
import UniformTypeIdentifiers

//MARK: a JSON file struct for exporting and changing JSON data
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
