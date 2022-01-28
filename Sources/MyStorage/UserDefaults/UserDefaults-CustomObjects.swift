//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 16.12.21.
//

import Foundation

//MARK: - extends UserDefaults to enable saving and retrieving custom objects
public extension UserDefaults {
    func getObject<T: Decodable>(forKey defaultName: String, castTo type: T.Type) -> T? {
        guard let fetchedData = self.data(forKey: defaultName) else {
            return nil
        }
        
        let decodedObject = try? JSONDecoder().decode(type, from: fetchedData)
        return decodedObject
    }
    
    func setObject<T: Encodable>(_ object: T, forKey defaultName: String) {
        guard let encodedObject = try? JSONEncoder().encode(object) else {
            return
        }
        
        self.set(encodedObject, forKey: defaultName)
    }
}
