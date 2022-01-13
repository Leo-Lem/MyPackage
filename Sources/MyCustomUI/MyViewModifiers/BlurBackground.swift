//
//  File.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 05.01.22.
//

import SwiftUI

//MARK: adding a darkening behind the view
public struct BlurBackground: ViewModifier {
    let enabled: Bool, opacity: Double, color: Color
    
    public func body(content: Content) -> some View {
        if enabled {
            ZStack {
                color.opacity(opacity)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                content
            }
        } else { content }
    }
}
