//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import SwiftUI

public extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
