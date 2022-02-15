//
//  ConditionalHidden.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI


public extension View {
    //MARK: - conditionally apply modifiers
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition { transform(self) } else { self }
    }
    
    @ViewBuilder func `if`<T, Content: View>(`let` optional: T?, transform: (Self, T) -> Content) -> some View {
        if optional != nil { transform(self, optional!) } else { self }
    }
    
    //MARK: - group modifiers together (for better readability)
    func group<Content: View>(transform: (Self) -> Content) -> some View { transform(self) }
}
