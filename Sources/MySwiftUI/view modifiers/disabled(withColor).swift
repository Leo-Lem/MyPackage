//
//  File.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 04.01.22.
//

import SwiftUI

//MARK: - extending the disabled modifier with on and off colors
public extension View {
    func disabled(_ disabled: Bool, on: Color, off: Color = .gray) -> some View {
        self
            .foregroundColor(disabled ? off : on)
            .disabled(disabled)
    }
}

//MARK: - Previews
struct View_disabledWithColor_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Hello-Button", action: {})
                .disabled(false, on: .green, off: .black)
            Button("Hello-Button", action: {})
                .disabled(true, on: .green, off: .black)
        }
    }
}
