//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 26.02.22.
//

import SwiftUI

/// <#Description#>
public struct DataPoint: Identifiable {
    
    /// <#Description#>
    public let value: Double,
               title: String,
               id: Int,
               color: Color
    
    /// <#Description#>
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - title: <#title description#>
    ///   - id: <#id description#>
    ///   - color: <#color description#>
    public init(
        _ value: Double,
        title: String = "",
        id: Int? = nil,
        color: Color? = nil
    ) {
        self.value = value
        self.title = title
        self.id = id ?? .random(in: 1..<Int.max)
        self.color = color ?? Color(hue: .random(in: 0...1), saturation: .random(in: 0...1), brightness: .random(in: 0...1))
    }
    
}

extension DataPoint: Hashable {}
extension DataPoint: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool { lhs.value < rhs.value }
    
}

public extension Array where Element == DataPoint {
    
    func maxValue() -> Double { self.max()?.value ?? 1 }
    
}

#if DEBUG
public extension Array where Element == DataPoint {
    static let examples: [Element] = [Double](count: 5, .random(in: 10...1000)).map { DataPoint($0, title: "Data Point") }
    
    static func lineExamples() -> [DataPoint] {
        var up = true,
            value = 50.0
        
        return (1...50).map { _ in
            value += Double.random(in: 1...10) * (up ? 1: -1)
            
            if (up && Int.random(in: 0..<10) == 0) || (!up && Int.random(in: 0..<7) == 0) {
                up.toggle()
            }
            
            return DataPoint(abs(value))
        }
    }
}
#endif
