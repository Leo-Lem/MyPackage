//
//  OptionalAssignmentOperator.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 31.12.21.
//

import Foundation

infix operator ?=: AssignmentPrecedence
public func ?= <T>(left: inout T, right: T?) {
    if let right = right {
        left = right
    }
}
