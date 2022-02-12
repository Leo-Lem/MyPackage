//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 29.01.22.
//

import SwiftUI

public struct LoadingDots: View {
    public var body: some View {
        Text(dots)
            .onReceive(timer) { _ in next() }
            .animation(dots)
    }

    @State private var dots = "."
    private let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

    private func next() {
        if self.dots.count < 3 {
            self.dots.append(".")
        } else { self.dots = "." }
    }
}

//MARK: - Previews
struct LoadingDots_Previews: PreviewProvider {
    static var previews: some View {
        LoadingDots()
    }
}
