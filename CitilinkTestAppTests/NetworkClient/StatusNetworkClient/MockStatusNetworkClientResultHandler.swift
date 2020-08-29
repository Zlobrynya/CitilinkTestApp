//
//  MockStatusNetworkClientResultHandler.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation
@testable import CitilinkTestApp

class MockStatusNetworkClientResultHandler: StatusNetworkClientResultHandler {
    // MARK: - Public Properties
    
    var didCallStatusRequestDidFailed = false
    var status: TaskStatus?
    var task = ""

    // MARK: - Public Functions
    
    func statusRequestDidFailed(_ error: Error) {
        didCallStatusRequestDidFailed = true
    }
    
    func statusRequestDidSucceed(_ status: TaskStatus, task: String) {
        self.status = status
        self.task = task
    }
    
    
}
