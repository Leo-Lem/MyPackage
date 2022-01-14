//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.01.22.
//

import SwiftUI

//MARK: different shorthands for modifiers I use often
extension View {
    public func animation<V: Equatable>(_ value: V) -> some View {
        self.animation(.default, value: value)
    }
    
    public func eraseToAnyView() -> AnyView { AnyView(self) }
    public func embedInNavigation() -> some View { NavigationView(content: { self }) }
}
