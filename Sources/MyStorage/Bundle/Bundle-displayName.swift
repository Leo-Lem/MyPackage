//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 21.02.22.
//

import Foundation

public extension Bundle {
    var displayName: String? { object(forInfoDictionaryKey: "CFBundleDisplayName") as? String }
}
