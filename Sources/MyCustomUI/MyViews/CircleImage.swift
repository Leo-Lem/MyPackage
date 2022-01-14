//
//  CircleImage.swift
//  Landmarks
//
//  Created by Leopold Lemmermann on 02.01.22.
//

import SwiftUI

public struct CircleImage: View {
    public let image: Image
    
    public var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 3)
            }
            .shadow(radius: 5)
            
    }
}

//MARK: - Previews
struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
