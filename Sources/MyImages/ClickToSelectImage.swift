//
//  SelectImageView.swift
//
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI

public struct ClickToSelectImage: View {
    @Binding private var image: Image?
    private let selectImage: () -> Void, prompt: String
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(image != nil ? .clear : .secondary)
            
            if image == nil {
                Text(prompt)
                    .foregroundColor(Color.primary)
                    .font(.headline)
            }
                
            image?
                .resizable()
                .scaledToFit()
        }
        .onTapGesture(perform: selectImage)
    }
    
    public init(_ image: Binding<Image?>,
                with selectImage: @escaping () -> Void,
                prompt: String = "Tap to select a picture") {
        self._image = image
        self.selectImage = selectImage
        self.prompt = prompt
    }
}

struct ClickToSelectImage_Previews: PreviewProvider {
    static var previews: some View {
        ClickToSelectImage(.constant(nil), with: {})
    }
}
