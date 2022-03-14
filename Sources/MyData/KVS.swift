//
//  KVS.swift
//  
//
//  Created by Leopold Lemmermann on 16.12.21.
//

import Foundation
import MyCollections



// MARK: - (UserDefaults)

public extension UserDefaults {
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getObject<T: Decodable>(forKey key: String) -> T? {
        guard
            let data = self.data(forKey: key),
            let decoded: T = try? JSONDecoder().decode(data)
        else { return nil }
        
        return decoded
    }
    
    /// <#Description#>
    func setObject<T: Encodable>(_ object: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        self.set(data, forKey: key)
    }
    
}

public extension UserDefaults {
    
    enum Key: String {
        case example
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    @inlinable func getValue<T>(forKey key: Key) -> T? {
        self.object(forKey: key.rawValue) as? T
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - key: <#key description#>
    @inlinable func setValue(_ value: Any?, forKey key: Key) {
        self.setValue(value, forKey: key.rawValue)
    }
    
    
    /// <#Description#>
    /// - Parameter keyedValues: <#keyedValues description#>
    @inlinable func setValuesForKeys(_ keyedValues: [Key : Any]) {
        let keyedValues = keyedValues.mapKeys(\.rawValue, uniquingKeysWith: { a, b in a })
        return self.setValuesForKeys(keyedValues)
    }
    
}



// MARK: - (CloudDefaults)

public final class CloudDefaults {
    
    /// <#Description#>
    public static let shared = CloudDefaults()
    
    /// <#Description#>
    public var prefix = "sync-"
    
    private var ignoreLocalChanges = false
    private init() {}
    deinit { NotificationCenter.default.removeObserver(self) }
    
}

extension CloudDefaults {
    
    /// <#Description#>
    public func start() {
        NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: NSUbiquitousKeyValueStore.default,
            queue: .main,
            using: updateLocal
        )

        NotificationCenter.default.addObserver(
            forName: UserDefaults.didChangeNotification,
            object: nil,
            queue: .main,
            using: updateRemote
        )

        NSUbiquitousKeyValueStore.default.synchronize()
    }
    
    private func updateRemote(note: Notification) {
        guard !ignoreLocalChanges else { return }

        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            guard key.hasPrefix(self.prefix) else { continue }
            NSUbiquitousKeyValueStore.default.set(value, forKey: key)
        }
    }

    private func updateLocal(note: Notification) {
        ignoreLocalChanges = true

        for (key, value) in NSUbiquitousKeyValueStore.default.dictionaryRepresentation {
            guard key.hasPrefix(self.prefix) else { continue }
            UserDefaults.standard.set(value, forKey: key)
        }

        ignoreLocalChanges = false
    }
    
}
