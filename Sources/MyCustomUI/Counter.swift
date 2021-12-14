//
//  Counter.swift
//
//
//  Created by Leopold Lemmermann on 19.07.21.
//

import SwiftUI
import MyLayout

public struct CounterView: View {
    private let label: String, count: String, height: CGFloat
    
    public var body: some View {
        GeometryReader { geo in
            HStack {
                Text(label).font().padding(.horizontal)
                Spacer(); Divider()
                Text("\(count)").font(padd: false)
                .frame(width: geo.size.width / 4)
            }
            .customBackground()
            .padding(.horizontal)
        }
        .frame(maxHeight: height)
    }
    
    public init(_ label: String, _ count: String, height: CGFloat = LayoutDefaults().rowHeight) {
        self.label = label
        self.count = count
        self.height = height
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView("count", "187")
    }
}
