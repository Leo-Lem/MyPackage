//
//  CustomFont.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

//MARK: standard font
public struct CustomFont: ViewModifier {
    let font: String, size: CGFloat, padd: Bool
    
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
}
