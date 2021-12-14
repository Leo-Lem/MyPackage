//
//  CustomModifiers.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: View extensions for modifier access
extension View {
    public func font(_ font: String = LayoutDefaults().textFont,
                     size: CGFloat = LayoutDefaults().textSize,
                     padd: Bool = true) -> some View {
        self.modifier(
            CustomFont(font, size: size, padd: padd))
    }
    public func customBackground(_ color: Color = Color.secondaryAlpha,
                                 cornerRadius: CGFloat = LayoutDefaults().cornerRadius,
                                 shadowRadius: CGFloat = LayoutDefaults().shadowRadius,
                                 shadowOffset: CGFloat = LayoutDefaults().shadowOffset) -> some View {
        self.modifier(
            CustomBackground(color, cornerRadius: cornerRadius, shadowRadius: shadowRadius, shadowOffset: shadowOffset, isRow: false))
    }
    public func customRowBackground(_ color: Color = Color.secondaryAlpha,
                                    cornerRadius: CGFloat = LayoutDefaults().cornerRadius,
                                    shadowRadius: CGFloat = LayoutDefaults().shadowRadius,
                                    shadowOffset: CGFloat = LayoutDefaults().shadowOffset) -> some View {
        self.modifier(
            CustomBackground(color, cornerRadius: cornerRadius, shadowRadius: shadowRadius, shadowOffset: shadowOffset, isRow: true))
    }
    public func backgroundImage(_ image: String = "SmokingArea", opacity: CGFloat = LayoutDefaults().opacity) -> some View {
        self.modifier(
            BackgroundImage(image, opacity: opacity))
    }
    public func hidden(_ isHidden: Bool) -> some View {
        self.modifier(
            ConditionalHidden(isHidden))
    }
    public func cornerRadius(_ radius: CGFloat = LayoutDefaults().cornerRadius, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius, corners: corners) )
    }
}
