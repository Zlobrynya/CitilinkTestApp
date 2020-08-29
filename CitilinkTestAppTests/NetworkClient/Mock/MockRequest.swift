//
//  MockRequest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation
@testable import CitilinkTestApp

class MockRequest: GetRequestProtocol {
    // MARK: - Public Properties
    
    var urlRequest: URLRequest?
    var didCallSend = false
    
    // MARK: - Lifecycle

    
    // MARK: - Public Functions
    
    func send() {
        didCallSend = true
    }
}
