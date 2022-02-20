//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

public extension PersonNameComponentsFormatter {
    convenience init(style: Style) {
        self.init()
        self.style = style
    }
}

public extension String {
    func getInitials() -> String {
        typealias Formatter = PersonNameComponentsFormatter
        if let components = Formatter().personNameComponents(from: self) {
            return Formatter(style: .abbreviated).string(from: components)
        } else {
            return "##"
        }
    }
}
