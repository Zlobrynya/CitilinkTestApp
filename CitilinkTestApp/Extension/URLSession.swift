//
//  URLSession.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

extension URLSession {
    /// Factory method to create a data task.
    /// - Parameters:
    ///   - request: Request
    ///   - onResult: OnResult closure
    ///   - onError: OnError closure
    func dataTask(
        with request: URLRequest,
        onResult: @escaping (NetworkResult) -> Void,
        onError: @escaping (Error) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                onError(error)
            } else if let data = data {
                let httpResponse = response as? HTTPURLResponse
                if
                    let httpResponse = httpResponse,
                    let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode),
                    statusCode.rawValue >= 400 {
                    //TODO
                    //onError(NetworkingError.httpError(statusCode: statusCode))
                } else {
                    onResult(NetworkResult(data: data, metadata: httpResponse))
                }
            } else {
                //TODO
                //onError()
            }
        })
    }
}
