//
//  GridStack.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

public struct GridStack<Content: View>: View {
    private let rows: Int, columns: Int, spacing: CGFloat, content: (Int, Int) -> Content
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(0..<columns, id: \.self) { column in content(row, column) }
                }
            }
        }
    }
    
    public init(rows: Int, columns: Int, spacing: CGFloat = 5, content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }
}

//MARK: - Previews
struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(rows: 5, columns: 5) { row, col in
            Text("Hello")
        }
    }
}
