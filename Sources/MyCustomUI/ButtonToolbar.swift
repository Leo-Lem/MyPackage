//
//  ButtonToolbar.swift
//
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI
import MyOthers

#if os(iOS)
public struct ButtonToolbar: ToolbarContent {
    private let leftLabel: String, rightLabel: String
    private let leftAction: () -> Void, rightAction: () -> Void
    private let leftDisabled: Bool, rightDisabled: Bool
    private let leftColor: Color, rightColor: Color
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(leftLabel, action: leftAction)
                .foregroundColor(leftDisabled ? leftColor.opacity(0.5) : leftColor)
                .disabled(leftDisabled)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(rightLabel, action: rightAction)
                .foregroundColor(rightDisabled ? rightColor.opacity(0.5) : rightColor)
                .disabled(rightDisabled)
        }
        
    }
    
    public init(_ labels: [String] = ["", ""],
                leftAction: @escaping () -> Void, rightAction: @escaping () -> Void,
                leftDisabled: Bool = false, rightDisabled: Bool = false,
                leftColor: Color = .primary, rightColor: Color = .primary) {
        self.leftLabel = labels[optional: 0] ?? ""
        self.rightLabel = labels[optional: 1] ?? ""
        self.leftAction = leftAction
        self.rightAction = rightAction
        self.leftDisabled = leftDisabled
        self.rightDisabled = rightDisabled
        self.leftColor = leftColor
        self.rightColor = rightColor
    }
}

struct ButtonToolbar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Text("Hello World")
            .toolbar {
                ButtonToolbar(["left", "right"], leftAction: {},  rightAction: {}, rightDisabled: true)
            }
        }
    }
}
#endif
