//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

extension PersonNameComponentsFormatter {
    public convenience init(style: Style) {
        self.init()
        self.style = style
    }
}

public func getInitials(for string: String) -> String {
    if let components = PersonNameComponentsFormatter().personNameComponents(from: string) {
        return PersonNameComponentsFormatter(style: .abbreviated).string(from: components)
    } else {
        return "##"
    }
}
