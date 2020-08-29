//
//  DebtorsNetworkClient.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol TaskNetworkClientResultHandler: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func taskRequestDidFailed(_ error: Error)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func taskRequestDidSucceed(_ task: String)
}

protocol TaskNetworkClientProtocol: NetworkRequestResultHandler {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func fetchTask(
        forFirstName firstName: String,
        withLastName lastName: String,
        andSecondaryName secondaryName: String,
        andBirthday birthday: String
    )

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    var resultHandler: TaskNetworkClientResultHandler? { get set }
}

final class TaskNetworkClient: TaskNetworkClientProtocol {
    // MARK: - External Dependencies

    weak var resultHandler: TaskNetworkClientResultHandler?

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

    func fetchTask(
        forFirstName firstName: String,
        withLastName lastName: String,
        andSecondaryName secondaryName: String,
        andBirthday birthday: String
    ) {
        let parameters = taskParameters(
            forFirstName: firstName,
            withLastName: lastName,
            andSecondaryName: secondaryName,
            andBirthday: birthday
        )
        do {
            let request = try networkClientFactory.get(
                url: constants.physical,
                parameters: parameters,
                resultHandler: self
            )
            request.send()
        } catch {
            resultHandler?.taskRequestDidFailed(error)
        }
    }

    // MARK: - NetworkRequestResultHandler Conformance

    public func requestDidSucceed(with result: NetworkResult) {
        do {
            let task = try jsonDecoder.decode(TaskMainResponse.self, from: result.data)
            resultHandler?.taskRequestDidSucceed(task.response.task)
        } catch {
            print(error)
            resultHandler?.taskRequestDidFailed(error)
        }
    }

    public func requestDidFail(with error: NetworkError) {
        print(error)
        resultHandler?.taskRequestDidFailed(error)
    }

    // MARK: - Private Functions

    private func taskParameters(
        forFirstName firstName: String,
        withLastName lastName: String,
        andSecondaryName secondaryName: String,
        andBirthday birthday: String
    ) -> TaskParameters {
        TaskParameters(
            token: constants.token,
            region: constants.region,
            firstName: firstName,
            secondName: secondaryName,
            lastName: lastName,
            birthdate: birthday
        )
    }
}
