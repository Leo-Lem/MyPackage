//
//  File.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 04.01.22.
//

import SwiftUI

//MARK: - extending the disabled modifier with on and off colors
public extension View {
    func disabled(_ disabled: Bool, colors: (on: Color, off: Color)) -> some View {
        self
            .foregroundColor(disabled ? colors.off : colors.on)
            .disabled(disabled)
    }
}

//MARK: - Previews
struct View_disabledWithColor_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Hello-Button", action: {})
                .disabled(false, colors: (.green, .black))
            Button("Hello-Button", action: {})
                .disabled(true, colors: (.red, .gray))
        }
    }
}
