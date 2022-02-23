//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI
import PhotosUI

#if canImport(UIKit)
public struct ImagePicker: UIViewControllerRepresentable {
    @Binding private var image: UIImage?
    
    public init(_ image: Binding<UIImage?>) {
        self._image = image
    }
    
    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        
        public init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        PHPickerViewController(configuration: PHPickerConfiguration(filter: .images), delegate: context.coordinator)
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    public typealias UIViewControllerType = PHPickerViewController
}
#endif
