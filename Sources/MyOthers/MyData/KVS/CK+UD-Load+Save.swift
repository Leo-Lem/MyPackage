//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

//saving the object to local and iCloud UserDefaults
func saveToKvs(_ object: Any, key: String) {
    UserDefaults.standard.set(object, forKey: key)
    NSUbiquitousKeyValueStore.default.set(object, forKey: key)
}

//loading the object (preferredly from the cloud defaults)
func loadFromKvs(key: String) -> Any? {
    if let object = NSUbiquitousKeyValueStore.default.object(forKey: key) {
        return object
    } else {
        return UserDefaults.standard.object(forKey: key)
    }
}
