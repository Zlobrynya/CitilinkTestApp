//
//  GetRequest.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol NetworkRequestResultHandler: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    func didSucceedWithResult(_ result: NetworkResult)
    
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    func didFailWithError(_ error: Error)
}

class GetRequest {
    // MARK: - Public Properties

    private(set) var urlRequest: URLRequest?

    // MARK: - Private Properties

    private var task: URLSessionDataTask?

    // MARK: - External Dependencies

    private let session: URLSession
    private weak var resultHandler: NetworkRequestResultHandler?

    // MARK: - Lifecycle

    init<T: Encodable>(
        url: String,
        parameters: T,
        jsonEncoder: JSONEncoder = JSONEncoder(),
        urlSession: URLSession = URLSession.shared,
        resultHandler: NetworkRequestResultHandler?
    ) {
        session = urlSession
        guard var components = URLComponents(string: url) else { return }
        components.queryItems = try! parameters.asURLQueryItem(jsonEncoder: jsonEncoder)
        urlRequest = URLRequest(url: components.url!)
        urlRequest?.httpMethod = "GET"
        self.resultHandler = resultHandler
    }

    // MARK: - Public Functions

    func send() {
        let resultHandler = self.resultHandler
        task = session.dataTask(
            with: urlRequest!,
            onResult: { resultHandler?.didSucceedWithResult($0) },
            onError: { resultHandler?.didFailWithError($0) }
        )
        task?.resume()
    }
}
