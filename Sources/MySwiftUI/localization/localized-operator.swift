//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 28.01.22.
//

import Foundation

postfix operator ~
public postfix func ~ (string: String) -> String { NSLocalizedString(string, comment: "") }
