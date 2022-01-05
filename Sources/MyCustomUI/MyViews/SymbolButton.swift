//
//  SymbolButton.swift
//  
//
//  Created by Leopold Lemmermann on 12.10.21.
//

import SwiftUI

public struct SymbolButton: View {
    private let imageName: String, action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
        }
    }
    
    public init(_ imageName: String,
                _ action: @escaping () -> Void = {}) {
        self.imageName = imageName
        self.action = action
    }
}

//MARK: shorthand for common closure expressions
extension SymbolButton {
    public init(_ imageName: String, toggle bool: Binding<Bool>) {
        self.imageName = imageName
        self.action = { bool.wrappedValue.toggle() }
    }
    
    public init(_ imageName: String, true bool: Binding<Bool>) {
        self.imageName = imageName
        self.action = { bool.wrappedValue = true }
    }
    
    public init(_ imageName: String, false bool: Binding<Bool>) {
        self.imageName = imageName
        self.action = { bool.wrappedValue = false }
    }
}

//MARK: - Previews
struct SymbolButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolButton("xmark.circle")
    }
}
