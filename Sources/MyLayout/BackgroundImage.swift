//
//  BackgroundImage.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: standard background image
public struct BackgroundImage: ViewModifier {
    private let imageName: String, opacity: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .background(
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(opacity)
            )
    }
    
    public init(_ imageName: String, opacity: CGFloat) {
        self.imageName = imageName
        self.opacity = opacity
    }
}
