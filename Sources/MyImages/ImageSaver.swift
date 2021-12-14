//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Leopold Lemmermann on 05.12.21.
//


import PhotosUI

public class ImageSaver: NSObject {
    private var successHandler: (() -> Void)?
    private var errorHandler: ((Error) -> Void)?
    
    public init(successHandler: (() -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
    }
    public func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveComplete), nil)
    }

    @objc public func saveComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
