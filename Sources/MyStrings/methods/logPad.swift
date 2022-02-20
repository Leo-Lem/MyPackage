//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Foundation

public extension String {
    func paddedForPrint() -> String {
        """
        ----------------------------------

        \(self)

        ----------------------------------
        """
    }
    
    mutating func padForPrint() {
        self = self.paddedForPrint()
    }
}
