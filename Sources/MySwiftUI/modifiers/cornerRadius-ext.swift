//
//  RoundedCorners.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

#if canImport(UIKit)
//MARK: round only specific corners of a view
public extension View {
    func cornerRadius(
        _ radius: CGFloat = 10,
        corners: UIRectCorner
    ) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    func cornerRadius<Style: ShapeStyle>(_ cornerRadius: Double, border: (style: Style, width: Double)) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(border.style, lineWidth: border.width)
            )
    }
}

private struct RoundedCorner: Shape {
    let radius: CGFloat, corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        )
    }
}
#endif
