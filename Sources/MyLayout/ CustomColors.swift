//
//  CustomColors.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: custom colors
extension Color {
    public static let primaryAlpha = Color.primary.opacity(LayoutDefaults().opacity),
                      secondaryAlpha = Color.secondary.opacity(LayoutDefaults().opacity)
}
