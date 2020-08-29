//
//  DebtorsNetworkClient.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol DebtorsNetworkClientResultHandler: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func debtorsRequestDidFailed(_ error: Error)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func debtorsRequestDidSucceed(_ debtors: [Debtor])
}

protocol DebtorsNetworkClientProtocol: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func fetchDebtorsForTask(_ task: String)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    var resultHandler: DebtorsNetworkClientResultHandler? { get set }
}

final class DebtorsNetworkClient: DebtorsNetworkClientProtocol, NetworkRequestResultHandler {
    // MARK: - External Dependencies

    weak var resultHandler: DebtorsNetworkClientResultHandler?

    private let constants: InputDataConstantsProtocol
    private let networkClientFactory: NetworkClientFactoryProtocol
    private let jsonDecoder: JSONDecoder

    // MARK: - Lifecycle

    init(
        constants: InputDataConstantsProtocol = InputDataConstants(),
        networkClientFactory: NetworkClientFactoryProtocol = NetworkClientFactory(),
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.constants = constants
        self.networkClientFactory = networkClientFactory
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Public Functions

    func fetchDebtorsForTask(_ task: String) {
        let parameters = DebtorsParameters(token: constants.token, task: task)
        do {
            let request = try networkClientFactory.get(
                url: constants.result,
                parameters: parameters,
                resultHandler: self
            )
            request.send()
        } catch {
            resultHandler?.debtorsRequestDidFailed(error)
        }
    }
    
    // MARK: - NetworkRequestResultHandler Conformance

    public func requestDidSucceed(with result: NetworkResult) {
        do {
            let response = try jsonDecoder.decode(MainResponse.self, from: result.data)
            guard let debtors = response.response.result.first?.result else { throw NetworkError.emptyResponse }
            resultHandler?.debtorsRequestDidSucceed(debtors)
        } catch {
            print(error)
            resultHandler?.debtorsRequestDidFailed(error)
        }
    }

    public func requestDidFail(with error: NetworkError) {
        resultHandler?.debtorsRequestDidFailed(error)
    }
    
}
