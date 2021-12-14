//
//  CustomFont.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: standard font
public struct CustomFont: ViewModifier {
    private let font: String, size: CGFloat, padd: Bool
    
    public func body(content: Content) -> some View {
        content
            .font(
                Font
                    .custom(font, size: size)
                    .bold()
            )
            .foregroundColor(.primary)
            .padding(padd ? 10 : 0)
    }
    
    public init(_ font: String, size: CGFloat, padd: Bool) {
        self.font = font
        self.size = size
        self.padd = padd
    }
}
