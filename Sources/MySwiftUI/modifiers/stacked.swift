//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import SwiftUI

public extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        self.offset(x: 0, y: Double(total - position) * 10)
    }
}
