//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

///MARK: Possibility to set dateFormat during initialization of DateFormatter().
extension DateFormatter {
    public convenience init(withDateFormat dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
