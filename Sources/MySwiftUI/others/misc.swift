//
//  misc.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

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

public extension Angle {
    
    /***/
    init(relative: Double) {
        self.init(radians: .twoPi * relative)
    }
    
    /***/
    static func relative(_ relative: Double) -> Angle {
        self.radians(.twoPi * relative)
    }
    
    ///
    var relative: Double {
        self.radians / .twoPi
    }
    
}
