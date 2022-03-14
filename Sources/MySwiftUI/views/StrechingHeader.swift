//
//  StretchingHeader.swift
//  
//
//  Created by Leopold Lemmermann on 09.03.22.
//

import SwiftUI

public struct StretchingHeader<Content: View>: View {
    
    let content: Content
    
    public init(
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geo in
            content
                .frame(width: geo.size.width, height: height(for: geo))
                .offset(y: offset(for: geo))
        }

    }
    
    private func height(for geo: GeometryProxy) -> CGFloat {
        let y = geo.frame(in: .global).minY
        
        return geo.size.height + max(0, y)
    }
    
    private func offset(for geo: GeometryProxy) -> CGFloat {
        let y = geo.frame(in: .global).minY
        return min(0, -y)
    }
    
}

#if DEBUG
// MARK: - (Previews)
struct StrechingHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            Section {} header: {
                StretchingHeader {
                    RadialGradient(colors: [.red, .green], center: .center, startRadius: 10, endRadius: 200)
                        .aspectRatio(4/1, contentMode: .fill)
                }
            }
        }
        
    }
}
#endif
