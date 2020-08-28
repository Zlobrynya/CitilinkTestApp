//
//  InputDataNetworkClient.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol DebtorsNetworkClientDelegate: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func debtorsRequestDidFailed(_ error: Error)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func debtorsRequestDidSucceed(_ error: Error)
}

protocol DebtorsNetworkClientProtocol {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func fetchDebtors()

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    var delegate: DebtorsNetworkClientDelegate? { get set }
}

final class DebtorsNetworkClient: DebtorsNetworkClientProtocol {
    // MARK: - External Dependencies

    weak var delegate: DebtorsNetworkClientDelegate?

    // MARK: - Lifecycle

    init() {}

    // MARK: - Public Functions

    func fetchDebtors() {}
}
