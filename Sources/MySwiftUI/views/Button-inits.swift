//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 28.01.22.
//

import SwiftUI

//MARK: - some custom initializers for actions often used
public extension Button where Label == Image {
    init(systemImage: String, action: @escaping () -> Void)  {
        self.init(action: action) { Image(systemName: systemImage) }
    }
    
    init(systemImage: String, toggle bool: Binding<Bool>) {
        self.init(systemImage: systemImage, action: { bool.wrappedValue.toggle() })
    }

    init(systemImage: String, true bool: Binding<Bool>) {
        self.init(systemImage: systemImage, action: { bool.wrappedValue = true })
    }

    init(systemImage: String, false bool: Binding<Bool>) {
        self.init(systemImage: systemImage, action: { bool.wrappedValue = false })
    }
}

public extension Button {
    init(toggle bool: Binding<Bool>, label: @escaping () -> Label) {
        self.init(action: { bool.wrappedValue.toggle() }, label: label)
    }

    init(true bool: Binding<Bool>, label: @escaping () -> Label) {
        self.init(action: { bool.wrappedValue = true }, label: label)
    }

    init(false bool: Binding<Bool>, label: @escaping () -> Label) {
        self.init(action: { bool.wrappedValue = false }, label: label)
    }
}
