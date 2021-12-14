//
//  DefaultValues.swift
//  
//
//  Created by Leopold Lemmermann on 12.11.21.
//

import SwiftUI

///MARK: initializable default values for layout
public class LayoutDefaults {
    public let cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOffset: CGFloat, opacity: CGFloat,
               rowHeight: CGFloat, symbolButtonSize: CGFloat, spacing: CGFloat,
               textFont: String, textSize: CGFloat
    
    public init(cornerRadius: CGFloat = 20, shadowRadius: CGFloat = 10, shadowOffset: CGFloat = 10, opacity: CGFloat = 0.8,
                rowHeight: CGFloat = 70, symbolButtonSize: CGFloat = 30, spacing: CGFloat = 20,
                textFont: String = "Verdana", textSize: CGFloat = 25) {
        
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.opacity = opacity
        self.rowHeight = rowHeight
        self.symbolButtonSize = symbolButtonSize
        self.spacing = spacing
        self.textFont = textFont
        self.textSize = textSize
    }
}
