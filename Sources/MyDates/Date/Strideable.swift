//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 21.01.22.
//

import Foundation

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
         other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date { self + n }
}


