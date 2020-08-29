//
//  DebtorsNetworkClient.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol TaskNetworkClientResultHandler: AnyObject {
    /// Called when the task was fetched failed.
    ///
    /// - Parameter debtors: Any error that occurred when trying to get task.
    func taskRequestDidFailed(_ error: Error)

    /// Called when the task was received successfully.
    ///
    /// - Parameter task: Task's id.
    func taskRequestDidSucceed(_ task: String)
}

protocol TaskNetworkClientProtocol: NetworkRequestResultHandler {
    /// Fetches task from the server.
    ///
    /// - Parameter lastName: Debtor's last name.
    /// - Parameter firstName: Debtor's first name.
    /// - Parameter secondName: Debtor's second name.
    /// - Parameter birthday: Debtor's birthday.
    func fetchTask(
        forFirstName firstName: String,
        withLastName lastName: String,
        andSecondaryName secondaryName: String,
        andBirthday birthday: String
    )

    /// The object that acts as the result handler for fetching task.
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
