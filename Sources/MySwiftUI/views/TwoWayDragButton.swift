//
//  TwoWayDragButton.swift
//  
//
//  Created by Leopold Lemmermann on 04.12.21.
//

import SwiftUI

/// A button which can be dragged in two directions to trigger a respective action.
public struct TwoWayDragButton: View {
    
    let symbols: (lead: String, mid: String, trail: String),
        actions: (lead: () -> Void, trail: () -> Void)
    
    public var body: some View {
        GeometryReader { geo in
            let edge = geo.size.width / 2 - 100
            let trigger = edge * 0.5
            let dragGesture = {
                DragGesture()
                    .onChanged {
                        if -edge...edge ~= $0.translation.width { self.offset = $0.translation }
                    }
                    .onEnded {
                        switch $0.translation.width {
                        case ...(-trigger): actions.lead()
                        case trigger...: actions.trail()
                        default: break
                        }
                        
                        self.offset = .zero
                    }
            }()
            
            HStack {
                ZStack {
                    Image(systemName: symbols.mid)
                        .resizable()
                        .opacity(1-Double(abs(offset.width) / trigger))
                    Image(systemName: symbols.lead)
                        .resizable()
                        .opacity(-Double(offset.width) / trigger)
                    Image(systemName: symbols.trail)
                        .resizable()
                        .opacity(Double(offset.width) / trigger)
                }
                .aspectRatio(1, contentMode: .fit)
                .offset(x: offset.width)
                .gesture(dragGesture)
                .animation(offset)
            }
            .padding(.horizontal)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    @State private var offset = CGSize.zero
    
    /// <#Description#>
    /// - Parameters:
    ///   - symbols: <#symbols description#>
    ///   - leadAction: <#leadAction description#>
    ///   - trailAction: <#trailAction description#>
    public init(
        symbols: (lead: String, mid: String, trail: String) = ("minus.circle", "circle", "plus.circle"),
        leadAction: @escaping () -> Void = {}, trailAction: @escaping () -> Void = {}
    ) {
        self.symbols = symbols
        self.actions = (leadAction, trailAction)
    }
    
}

#if DEBUG
// MARK: - (Previews)
struct TwoWayDragButton_Previews: PreviewProvider {
    static var previews: some View {
        TwoWayDragButton()
            .frame(height: 100, alignment: .center)
    }
}
#endif
