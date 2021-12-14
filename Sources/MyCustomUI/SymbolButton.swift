//
//  SymbolButton.swift
//  
//
//  Created by Leopold Lemmermann on 12.10.21.
//

import SwiftUI
import MyLayout

public struct SymbolButton: View {
    private let imageName: String, size: CGFloat, action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font("Calibri", size: size)
        }
    }
    
    public init(_ imageName: String, size: CGFloat = LayoutDefaults().textSize, _ action: @escaping () -> Void = {}) {
        self.imageName = imageName
        self.size = size
        self.action = action
    }
}

struct SymbolButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolButton("xmark.circle")
    }
}
