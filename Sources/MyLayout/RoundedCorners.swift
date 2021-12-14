//
//  RoundedCorners.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: round only specific corners of a view
public struct RoundedCorner: Shape {
    private let radius: CGFloat, corners: UIRectCorner
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
    public init(_ radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
}
