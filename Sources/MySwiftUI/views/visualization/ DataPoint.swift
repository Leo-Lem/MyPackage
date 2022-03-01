//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 26.02.22.
//

import SwiftUI

/***/
public struct DataPoint: Identifiable {
    ///
    public let value: Double,
               ///
               title: String,
               ///
               id: Int,
               ///
               color: Color
               
    /***/
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

extension DataPoint: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
    
}

#if DEBUG
extension Array where Element == DataPoint {
    static let examples: [Element] = [Double](count: 5, .random(in: 10...1000)).map { DataPoint($0, title: "Data Point") }
    
    static func lineExamples() -> [DataPoint] {
        var isGoingUp = true
        var currentValue = 50.0

        return (1...50).map { _ in
            if isGoingUp {
                currentValue += Double.random(in: 1...10)
            } else {
                currentValue += -Double.random(in: 1...10)
            }

            if isGoingUp {
                if Int.random(in: 0..<10) == 0 {
                    isGoingUp.toggle()
                }
            } else {
                if Int.random(in: 0..<7) == 0 {
                    isGoingUp.toggle()
                }
            }

            return DataPoint(abs(currentValue))
        }
    }
}
#endif
