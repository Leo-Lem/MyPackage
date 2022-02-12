//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import SwiftUI

public extension View {
    @ViewBuilder func group<Content: View>(transform: (Self) -> Content) -> some View { transform(self) }
}
