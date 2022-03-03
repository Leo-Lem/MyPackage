//
//  async.swift
//  
//
//  Created by Leopold Lemmermann on 18.01.22.
//

import Foundation

//MARK: - Task
public extension Task where Success == Never, Failure == Never {
    
    /***/
    static func sleep(
        seconds: Double
    ) async throws {
        let duration = UInt64(seconds) * 1_000_000_000
        try await self.sleep(nanoseconds: duration)
    }
    
}
