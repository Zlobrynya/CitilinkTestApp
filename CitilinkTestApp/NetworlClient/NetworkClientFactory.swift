//
//  NetworkClientFactory.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol NetworkClientFactoryProtocol {
    ///  Description
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func get<T: Encodable>(url: String, parameters: T, resultHandler: NetworkRequestResultHandler?) throws -> GetRequest
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

    func get<T: Encodable>(url: String, parameters: T, resultHandler: NetworkRequestResultHandler?) throws -> GetRequest {
        try GetRequest(
            url: url,
            parameters: parameters,
            jsonEncoder: jsonEncoder,
            urlSession: session,
            resultHandler: resultHandler
        )
    }
}
