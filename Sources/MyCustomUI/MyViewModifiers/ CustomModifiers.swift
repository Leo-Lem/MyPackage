//
//  CustomModifiers.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

//MARK: view extensions for modifier access
extension View {
    public func font(_ font: String = "Calibri",
                     color: Color = .primary,
                     size: CGFloat = 20,
                     padd: Bool = true) -> some View {
        self.modifier(
            CustomFont(font: font, size: size, color: color, padd: padd))
    }
    
    public func backgroundImage(_ image: String, opacity: CGFloat) -> some View {
        self.modifier(
            BackgroundImage(imageName: image, opacity: opacity))
    }
    
    public func hidden(_ isHidden: Bool) -> some View {
        self.modifier(
            ConditionalHidden(hidden: isHidden))
    }
    #if canImport(UIKit)
    public func cornerRadius(_ radius: CGFloat = 10, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    #endif
    
    public func webLink(url: URL) -> some View {
        self.modifier(WebLink(url: url))
    }
    
    public func disabled(_ disabled: Bool, on: Color, off: Color = .gray) -> some View {
        self.modifier(DisabledWithColor(disabled: disabled, on: on, off: off))
    }
    
    public func blurBackground(_ enabled: Bool = true, opacity: CGFloat = 0.6, color: Color = .black) -> some View {
        self.modifier(BlurBackground(enabled: enabled, opacity: opacity, color: color))
    }
}
