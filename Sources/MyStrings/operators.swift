//
//  operators.swift
//  
//
//  Created by Leopold Lemmermann on 27.02.22.
//

import Foundation

public extension URL {
    
    static func + <S: StringProtocol>(
        _ url: URL,
        appendee: @autoclosure () -> S
    ) -> URL {
        url.appendingPathComponent(String(appendee()))
    }
    
    static func / <S: StringProtocol>(
        _ url: URL,
        appendee: @autoclosure () -> S
    ) -> URL {
        url.appendingPathComponent(String(appendee()))
    }
    
    static func += <S: StringProtocol>(
        _ url: inout URL,
        appendee: @autoclosure () -> S
    ) {
        url.appendPathComponent(String(appendee()))
    }
    
}
