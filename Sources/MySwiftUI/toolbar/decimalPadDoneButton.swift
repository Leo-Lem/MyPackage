//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI

public struct KeyboardDoneButton: ToolbarContent {
    public let action: () -> Void
    
    public var body: some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button("Done", action: action)
        }
    }
    
    public init(_ focus: FocusState<Bool>.Binding) {
        self.action = { focus.wrappedValue = false }
    }
}

