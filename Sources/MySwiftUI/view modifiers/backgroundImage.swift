//
//  BackgroundImage.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

//MARK: - standard background image
public extension View {
    func background(image: String, opacity: Double) -> some View {
        self.background {
            Image(decorative: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(opacity)
        }
    }
}
