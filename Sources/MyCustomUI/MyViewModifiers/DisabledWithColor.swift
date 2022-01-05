//
//  File.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 04.01.22.
//

import SwiftUI

//MARK: extending the disabled modifier with on and off colors
public struct DisabledWithColor: ViewModifier {
    let disabled: Bool, on: Color, off: Color
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(disabled ? off : on)
            .disabled(disabled)
    }
}
