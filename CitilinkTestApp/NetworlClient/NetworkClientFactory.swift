//
//  NetworkClientFactory.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol NetworkClientFactoryProtocol {
    /// Creates a `GetRequest` with HTTP method GET.
    ///
    /// - Parameter url: The url for the request.
    /// - Parameter parameters: The parameters needed for the request.
    /// - Parameter resultHandler: The `NetworkRequestResultHandler` which will be notified about the result of the request.
    /// - Returns: The `GetRequest`.
    func get<T: Encodable>(url: String, parameters: T, resultHandler: NetworkRequestResultHandler?) throws -> GetRequestProtocol
}

struct NetworkClientFactory: NetworkClientFactoryProtocol {
    // MARK: - External Dependencies

    private let session: URLSession
    private let jsonEncoder: JSONEncoder

    // MARK: - Lifecycle

    init(session: URLSession = URLSession.shared, jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.session = session
        self.jsonEncoder = jsonEncoder
    }

    // MARK: - Public Functions

    func get<T: Encodable>(url: String, parameters: T, resultHandler: NetworkRequestResultHandler?) throws -> GetRequestProtocol {
        try GetRequest(
            url: url,
            parameters: parameters,
            jsonEncoder: jsonEncoder,
            urlSession: session,
            resultHandler: resultHandler
        )
    }
}
