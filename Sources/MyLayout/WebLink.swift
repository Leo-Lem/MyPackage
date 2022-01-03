//
//  WebLink.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 25.12.21.
//

import SwiftUI

public struct WebLink: ViewModifier {
    let url: URL
    
    public func body(content: Content) -> some View {
        Link(destination: url) {
            content
        }
    }
}
