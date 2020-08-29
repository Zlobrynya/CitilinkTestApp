//
//  MockNetworkClientFactory.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation
@testable import CitilinkTestApp

class MockNetworkClientFactory: NetworkClientFactoryProtocol {
    
    // MARK: - Public Properties

    var shouldThrowError = false
    var url = ""
    var request: MockRequest?
    var resultHandler: NetworkRequestResultHandler?
    
    // MARK: - Public Functions
    
    func get<T>(url: String, parameters: T, resultHandler: NetworkRequestResultHandler?) throws -> GetRequestProtocol where T : Encodable {
        guard !shouldThrowError else { throw NetworkError.emptyResponse }
        request = MockRequest()
        self.url = url
        self.resultHandler = resultHandler
        return request!
    }
    
}
