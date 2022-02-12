//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.01.22.
//

import SwiftUI

//MARK: - different shorthands for modifiers I use often
public extension View {
    func animation<V: Equatable>(_ value: V) -> some View {
        self.animation(.default, value: value)
    }
    
    func font(_ font: String = "Calibri", size: CGFloat = 20) -> some View {
        self.font(.custom(font, size: size))
    }
}
