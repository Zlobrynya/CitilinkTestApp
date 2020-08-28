//
//  Deobfuscation.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol DeobfuscationProtocol {
    /// This method reveals the original string from the obfuscated
    /// byte array passed in. The salt must be the same as the one
    /// used to encrypt it in the first place.
    ///
    /// - Parameter key: The byte array to reveal.
    /// - Returns: The original string.
    func reveal(key: [UInt8]) -> String
}

class Deobfuscation: DeobfuscationProtocol {
    // MARK: - External Dependencies

    private var salt: String

    // MARK: - Lifecycle

    public init?(bundle: Bundle = Bundle.main) {
        guard let bundleIdentifier = bundle.bundleIdentifier else { return nil }
        salt = String(describing: AppDelegate.self) + bundleIdentifier
        print(salt)
    }

    // MARK: - Public Functions

    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](salt.utf8)
        let length = cipher.count

        var decrypted = [UInt8]()

        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }

        return String(bytes: decrypted, encoding: .utf8)!
    }
}
