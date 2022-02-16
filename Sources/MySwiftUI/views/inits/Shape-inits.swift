//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI

public extension Shape where Self == Rectangle {
    static var rectangle: Self { Rectangle() }
}

public extension Shape where Self == RoundedRectangle {
    static func roundedRectangle(
        cornerRadius: CGFloat,
        style: RoundedCornerStyle = .circular
    ) -> Self {
        RoundedRectangle(cornerRadius: cornerRadius, style: style)
    }
    
    static func roundedRectangle(
        cornerSize: CGSize,
        style: RoundedCornerStyle = .circular
    ) -> Self {
        RoundedRectangle(cornerSize: cornerSize, style: style)
    }
}

public extension Shape where Self == Circle {
    static var circle: Circle { Circle() }
}

public extension Shape where Self == Ellipse {
    static var ellipse: Ellipse { Ellipse() }
}

public extension Shape where Self == Capsule {
    static var capsule: Capsule { Capsule() }
    static func capsule(style: RoundedCornerStyle) -> Capsule { Capsule(style: style) }
}
