//
//  ProminentPrint.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 11.01.22.
//

import Foundation

public func print(items: Any..., prominent: Bool) {
    prominent ? print(items.map { String(describing: $0).logPadded() }) : print(items)
}
