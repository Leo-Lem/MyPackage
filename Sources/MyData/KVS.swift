//
//  KVS.swift
//  
//
//  Created by Leopold Lemmermann on 16.12.21.
//

import Foundation

//MARK: - UserDefaults
public extension UserDefaults {
    func getObject<T: Decodable>(forKey key: String) -> T? {
        guard
            let data = self.data(forKey: key),
            let decoded: T = try? JSONDecoder().decode(data)
        else { return nil }
        
        return decoded
    }
    
    func setObject<T: Encodable>(_ object: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        self.set(data, forKey: key)
    }
}
