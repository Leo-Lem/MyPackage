//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MyNumbers

public extension ForEach where Data == Range<Int>, ID == Int, Content: View {
    init(_ data: ClosedRange<Int>, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (ID) -> Content) {
        self.init((data.lowerBound)..<(data.upperBound+), id: id, content: content)
    }
    
    init(_ data: ClosedRange<Int>, @ViewBuilder content: @escaping (ID) -> Content) {
        self.init(data, id: \.self, content: content)
    }
}
