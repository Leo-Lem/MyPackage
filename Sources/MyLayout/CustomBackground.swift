//
//  CustomBackground.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: standard background for subviews
public struct CustomBackground: ViewModifier {
    private let color: Color, cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOffset: CGFloat, isRow: Bool
    
    public func body(content: Content) -> some View {
        if isRow {
            content
                .listRowBackground(
                    color
                        .cornerRadius(cornerRadius)
                        .shadow(color: Color.black, radius: shadowRadius, y: shadowOffset)
                )
        }
        else {
            content
                .background(
                    color
                        .cornerRadius(cornerRadius)
                        .shadow(color: Color.black, radius: shadowRadius, y: shadowOffset)
                )
        }
    }
    
    public init(_ color: Color, cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOffset: CGFloat, isRow: Bool) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.isRow = isRow
    }
}
