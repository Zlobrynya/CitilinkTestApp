//
//  MockTaskNetworkClientResultHandler.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation
@testable import CitilinkTestApp

class MockTaskNetworkClientResultHandler: TaskNetworkClientResultHandler {
    
    // MARK: - Public Properties

    var didCallTaskRequestDidFailed = false
    var task = ""
    
    // MARK: - Public Properties

    func taskRequestDidFailed(_ error: Error) {
        didCallTaskRequestDidFailed = true
    }

    func taskRequestDidSucceed(_ task: String) {
        self.task = task
    }
    
}
