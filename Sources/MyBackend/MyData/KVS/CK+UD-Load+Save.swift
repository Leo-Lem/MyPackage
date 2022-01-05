//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import Foundation

public struct KVSHandler {
    public let localDefaults: UserDefaults?,
               cloudDefaults: NSUbiquitousKeyValueStore?
    
    public init(local: Bool = true, cloud: Bool = false) {
        self.localDefaults = local ? UserDefaults.standard : nil
        self.cloudDefaults = cloud ? NSUbiquitousKeyValueStore.default : nil
    }
    
    //saving the object to local and iCloud UserDefaults
    public func save(_ object: Any, key: String) {
        localDefaults?.set(object, forKey: key)
        cloudDefaults?.set(object, forKey: key)
    }

    //loading the object (preferredly from the cloud defaults)
    public func load(key: String) -> Any? {
        if let object = cloudDefaults?.object(forKey: key) {
            return object
        } else {
            return localDefaults.object(forKey: key)
        }
    }
}

