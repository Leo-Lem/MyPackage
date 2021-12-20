//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

extension PersonNameComponentsFormatter {
    convenience init(style: Style) {
        self.init()
        self.style = style
    }
}

func getInitials(for string: String) -> String {
    if let components = PersonNameComponentsFormatter().personNameComponents(from: string) {
        return PersonNameComponentsFormatter(style: .abbreviated).string(from: components)
    }
    return "##"
}
