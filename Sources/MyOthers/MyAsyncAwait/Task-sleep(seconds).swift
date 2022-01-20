//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 18.01.22.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Int) async throws {
        let duration = UInt64(seconds) * 1_000_000_000
        try await self.sleep(nanoseconds: duration)
    }
}
