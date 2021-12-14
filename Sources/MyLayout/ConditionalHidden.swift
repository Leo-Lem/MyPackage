//
//  ConditionalHidden.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

///MARK: conditionally hide a view
public struct ConditionalHidden: ViewModifier {
    private let hidden: Bool
    
    public func body(content: Content) -> some View {
        if hidden {
            content.hidden()
        } else {
            content
        }
    }
    
    public init(_ hidden: Bool) {
        self.hidden = hidden
    }
}
