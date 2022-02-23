//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import Foundation

public extension URL {
    
    static func + <S: StringProtocol>(lhs: URL, rhs: S) -> URL {
        lhs.appendingPathComponent(String(rhs))
    }
    
    static func / <S: StringProtocol>(lhs: URL, rhs: S) -> URL {
        lhs.appendingPathComponent(String(rhs))
    }

    
    static func += <S: StringProtocol>(lhs: inout URL, rhs: S) {
        lhs.appendPathComponent(String(rhs))
    }
    
}

//MARK: - SwiftUI
import SwiftUI

public extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
}

public extension CGSize {
    
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: rhs.width + rhs.height)
    }
    
}


