//
//  LoadingSpinnerView.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 08.01.22.
//

import SwiftUI

struct Spinner: View {
    let size: CGSize?
    
    var body: some View {
        circle
            .trim(from: 0.1, to: 1)
            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
            .shadow(color: .primary, radius: 3)
            .rotationEffect(rotation)
            .onReceive(timer) { _ in
                withAnimation { rotation += .degrees(90) }
            }
    }
    
    @State private var rotation = Angle.degrees(270)
    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    private var circle: Circle {
        size != nil ?
            Circle().frame(width: size!.width, height: size!.height) as! Circle :
            Circle()
    }
}

extension Spinner {
    enum Size { case tiny, small, medium, large, dynamic }
    init(size: Size) {
        switch size {
        case .large: self.size = CGSize(width: 400, height: 400)
        case .medium: self.size = CGSize(width: 200, height: 200)
        case .small: self.size = CGSize(width: 50, height: 50)
        case .tiny: self.size = CGSize(width: 10, height: 10)
        case .dynamic: self.size = nil
        }
    }
}

//MARK: - Previews
struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner(size: .large)
    }
}
