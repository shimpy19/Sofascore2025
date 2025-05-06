//
//  TokenStorage.swift
//  Sofa
//
//  Created by Akademija on 16.04.2025..
//

import Foundation
import KeychainAccess

enum TokenStorage {
    private static let keychain = Keychain(service: "com.akademija.sofa")

    static func save(token: String) throws {
        try keychain.set(token, key: "authToken")
    }

    static func get() -> String? {
        try? keychain.get("authToken")
    }

    static func clear() {
        try? keychain.remove("authToken")
    }
}

