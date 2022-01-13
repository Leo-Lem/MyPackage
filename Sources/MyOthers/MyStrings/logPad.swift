//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Foundation

extension String {
    public func logPadded() -> String {
        """
        ----------------------------------

        \(self)

        ----------------------------------
        """
    }
}
