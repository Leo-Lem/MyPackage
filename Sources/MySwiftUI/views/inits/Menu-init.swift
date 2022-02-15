//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI

public extension Menu where Label == Image {
    init(systemImage: String, content: () -> Content, primaryAction: (() -> Void)? = nil) {
        if let primaryAction = primaryAction {
            self.init(content: content, label: { Image(systemName: systemImage) }, primaryAction: primaryAction)
        } else {
            self.init(content: content, label: { Image(systemName: systemImage) })
        }
    }
}
