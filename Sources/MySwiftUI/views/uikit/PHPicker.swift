//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import PhotosUI

#if canImport(UIKit)
extension PHPickerViewController {
    public convenience init(configuration: PHPickerConfiguration, delegate: PHPickerViewControllerDelegate) {
        self.init(configuration: configuration)
        self.delegate = delegate
    }
}

extension PHPickerConfiguration {
    public init(filter: PHPickerFilter) {
        self.init()
        self.filter = filter
    }
}
#endif
