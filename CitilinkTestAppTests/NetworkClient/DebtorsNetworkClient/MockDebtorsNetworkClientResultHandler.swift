//
//  MockDebtorsNetworkClientResultHandler.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation
@testable import CitilinkTestApp

class MockDebtorsNetworkClientResultHandler: DebtorsNetworkClientResultHandler {

    
    // MARK: - Public Properties

    var didCallDebtorsRequestDidFailed = false
    var debtors = [Debtor]()
    
    // MARK: - Public Properties

    func debtorsRequestDidFailed(_ error: Error) {
        didCallDebtorsRequestDidFailed = true
    }
    
    func debtorsRequestDidSucceed(_ debtors: [Debtor]) {
        self.debtors = debtors
    }
    
    
}
