//
//  CustomModifiers.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

//MARK: View extensions for modifier access
extension View {
    public func font(_ font: String = LayoutDefaults.textFont,
                     color: Color = .primary,
                     size: CGFloat = LayoutDefaults.textSize,
                     padd: Bool = true) -> some View {
        self.modifier(
            CustomFont(font: font, size: size, color: color, padd: padd))
    }
    
    public func backgroundImage(_ image: String = LayoutDefaults.backgroundImage,
                                opacity: CGFloat = LayoutDefaults.opacity) -> some View {
        self.modifier(
            BackgroundImage(imageName: image, opacity: opacity))
    }
    
    public func hidden(_ isHidden: Bool) -> some View {
        self.modifier(
            ConditionalHidden(hidden: isHidden))
    }
    
    public func cornerRadius(_ radius: CGFloat = LayoutDefaults.cornerRadius, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
