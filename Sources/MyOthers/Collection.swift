//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import Foundation

//MARK: returns an optional value instead of failing when index is out of range
extension Collection where Indices.Iterator.Element == Index {
    public subscript(optional index: Index) -> Iterator.Element? {
        (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
