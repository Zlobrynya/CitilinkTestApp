//
//  NetworksError.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrl
    case error(_ error: Error)
    case statusCode(_ statusCode: HTTPStatusCode)
    case emptyResponse
}
