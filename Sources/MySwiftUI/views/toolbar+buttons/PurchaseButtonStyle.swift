//
//  PurchaseButtonStyle.swift
//  
//
//  Created by Leopold Lemmermann on 08.03.22.
//

import SwiftUI

public extension ButtonStyle where Self == PurchaseButtonStyle {
    
    /// <#Description#>
    static var purchase: Self { .init() }
    
}


/// <#Description#>
public struct PurchaseButtonStyle: ButtonStyle {

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 200, minHeight: 44)
            .background(Color.accentColor)
            .clipShape(.capsule)
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
    
}
