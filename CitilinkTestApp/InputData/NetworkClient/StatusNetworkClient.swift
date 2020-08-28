//
//  StatusNetworkClient.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol StatusNetworkClientResultHandler: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func statusRequestDidFailed(_ error: Error)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func statusRequestDidSucceed(_ status: TaskStatus, task: String)
}

protocol StatusNetworkClientProtocol: NetworkRequestResultHandler {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func fetchStatusForTask(_ task: String)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    var resultHandler: StatusNetworkClientResultHandler? { get set }
}

final class StatusNetworkClient: StatusNetworkClientProtocol {
    
    // MARK: - External Dependencies
    
    weak var resultHandler: StatusNetworkClientResultHandler?
    
    private let constants: InputDataConstantsProtocol
    private let networkClientFactory: NetworkClientFactoryProtocol
    private let jsonDecoder: JSONDecoder

    // MARK: - Private Properties

    private var task = ""
    
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

    func fetchStatusForTask(_ task: String) {
        self.task = task
        let parameters = DebtorsParameters(token: constants.token, task: task)
        do {
            let request = try networkClientFactory.get(
                url: constants.status,
                parameters: parameters,
                resultHandler: self
            )
            request.send()
        } catch {
            Log.error(error)
        }
    }
    
    // MARK: - NetworkRequestResultHandler Conformance
    
    func requestDidSucceed(with result: NetworkResult) {
        do {
            let response = try jsonDecoder.decode(StatusMainResponse.self, from: result.data)
            guard let status = TaskStatus.init(rawValue: response.response.status) else { throw NetworkError.emptyResponse }
            resultHandler?.statusRequestDidSucceed(status, task: task)
        } catch {
            print(error)
            resultHandler?.statusRequestDidFailed(error)
        }
    }
    
    func requestDidFail(with error: NetworkError) {
        resultHandler?.statusRequestDidFailed(error)
    }
}
