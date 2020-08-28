//
//  Plist.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

/// Represents a `Plist` with an associated generic value type conforming to the `Codable` protocol.
public protocol PlistProtocol {
    /// Codable type that should be returned by decode.
    associatedtype T

    /// Returns the value associated with the specified plist. If the `Plist`'s
    /// resource name is not specified it will default to the default bundled
    /// Info.plist file.
    ///
    /// - Returns: A instance of `T` or nil if the resource was not found or failed to decode.
    func decode() -> T?
}

public struct Plist<T: Codable>: PlistProtocol {
    // MARK: - External Dependencies

    private let resourceName: String?
    private let bundle: Bundle

    // MARK: - Lifecycle

    public init(resourceName: String? = nil, bundle: Bundle) {
        self.resourceName = resourceName
        self.bundle = bundle
    }
    
    // MARK: - Public Functions

    public func decode() -> T? {
        guard let resourceName = resourceName else {
            return decodeFromBundledInfo()
        }

        guard let path = bundle.path(forResource: resourceName, ofType: "plist", inDirectory: nil) else {
            // Should be a debug log
            print("Resource: \(resourceName) not found in bundle: \(bundle)")
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    
    private func decodeFromBundledInfo() -> T? {
        guard let infoDictionary = bundle.infoDictionary else {
            print("infoDictionary for bundle: \(bundle) is nil.")
            return nil
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: infoDictionary)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }
}
