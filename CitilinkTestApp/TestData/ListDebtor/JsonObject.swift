//
//  JsonArray.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

/// Holds the contents of a JSON file as data and decoded item.
public protocol JsonObjectProtocol {

    /// Type of the item in the JSON file.
    associatedtype T

    /// Contents of the JSON file as decoded item.
    var decodedItem: T { get }

    /// Contents of the JSON file as `Data`.
    var data: Data { get }
}

public struct JsonObject<T: Decodable>: JsonObjectProtocol {
    
    enum Error: LocalizedError {
        case invalidUrl
    }

    // MARK: - Public Properties

    public let decodedItem: T
    public let data: Data

    // MARK: - Lifecycle

    public init(fileName: String, decoder: JSONDecoder = JSONDecoder(), bundle: Bundle = .main) throws {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else { throw Error.invalidUrl }
        data = try Data(contentsOf: url)
        decodedItem = try decoder.decode(T.self, from: data)
    }
}

