//
//  TwoWayDragButton.swift
//  
//
//  Created by Leopold Lemmermann on 04.12.21.
//

import SwiftUI
import MyOthers

public struct TwoWayDragButton: View {
    let mainSymbol: String, leftSymbol: String, rightSymbol: String
    let leftAction: () -> Void, rightAction: () -> Void
    
    @State private var offset = CGSize.zero
    private let edgeAt: CGFloat, size: CGFloat
    private var actionBorder: CGFloat { 0.5 * edgeAt}
    
    public var body: some View {
        HStack {
            Spacer(minLength: edgeAt)
            ZStack {
                Image(systemName: mainSymbol)
                    .font(.system(size: size))
                    .opacity(1 - (Double(abs(offset.width / actionBorder))))
                Image(systemName: leftSymbol)
                    .font(.system(size: size))
                    .opacity(-Double(offset.width) / actionBorder)
                Image(systemName: rightSymbol)
                    .font(.system(size: size))
                    .opacity(Double(offset.width) / actionBorder)
            }
            .animation(.default, value: offset)
            .aspectRatio(1, contentMode: .fill)
            .offset(x: offset.width)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        var drag: CGFloat { gesture.translation.width }
                        
                        if drag < edgeAt && drag > -edgeAt {
                            self.offset = gesture.translation
                        }
                    }
                    .onEnded { gesture in
                        var drag: CGFloat { gesture.translation.width }
                        
                        if drag < -actionBorder { leftAction() }
                        if drag > actionBorder { rightAction() }
                        
                        self.offset = .zero
                    }
            )
            Spacer(minLength: edgeAt)
        }
        .scaledToFit()
    }
    
    public init(symbols: [String] = [],
                size: CGFloat = 75, edgeAt: CGFloat = 125,
                leftAction: @escaping () -> Void = {}, rightAction: @escaping () -> Void = {}) {
        self.mainSymbol = symbols[optional: 0] ?? "circle"
        self.leftSymbol = symbols[optional: 1] ?? "minus.circle"
        self.rightSymbol = symbols[optional: 2] ?? "plus.circle"
        self.size = size
        self.edgeAt = edgeAt
        self.leftAction = leftAction
        self.rightAction = rightAction
    }
}

struct TwoWayDragButton_Previews: PreviewProvider {
    static var previews: some View {
        TwoWayDragButton()
    }
}
