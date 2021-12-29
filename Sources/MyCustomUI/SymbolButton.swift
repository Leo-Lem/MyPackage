//
//  SymbolButton.swift
//  
//
//  Created by Leopold Lemmermann on 12.10.21.
//

import SwiftUI
import MyLayout

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

struct SymbolButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolButton("xmark.circle")
    }
}
