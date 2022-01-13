//
//  RoundedCorners.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

#if canImport(UIKit)
//MARK: round only specific corners of a view
public struct RoundedCorner: Shape {
    let radius: CGFloat, corners: UIRectCorner
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif
