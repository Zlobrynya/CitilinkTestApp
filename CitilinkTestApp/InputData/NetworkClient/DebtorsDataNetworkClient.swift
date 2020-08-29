//
//  DebtorsDataNetworkClient.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol DebtorsDataNetworkResultHandler: AnyObject {
    
    /// Called when the debtors data was fetched failed.
    ///
    /// - Parameter error: Any error that occurred when trying to get debtors data.
    func debtorsDataRequestDidFailed(_ error: Error)

    /// Called when the debtors data was received successfully.
    ///
    /// - Parameter debtors: An array of debtors received from the server.
    func debtorsDataRequestDidSucceed(_ debtors: [Debtor])
}

protocol DebtorsDataNetworkClientProtocol: AnyObject {
    /// Fetches debtors data from the server.
    ///
    /// - Parameter lastName: Debtor's last name.
    /// - Parameter firstName: Debtor's first name.
    /// - Parameter secondName: Debtor's second name.
    /// - Parameter birthday: Debtor's birthday.
    func fetchData(
        forFirstName firstName: String,
        withLastName lastName: String,
        andSecondaryName secondaryName: String,
        andBirthday birthday: String
    )

    /// The object that acts as the result handler for fetching debtors data.
    var resultHandler: DebtorsDataNetworkResultHandler? { get set }
}

final class DebtorsDataNetworkClient: DebtorsDataNetworkClientProtocol,
    TaskNetworkClientResultHandler,
    DebtorsNetworkClientResultHandler,
    StatusNetworkClientResultHandler {
    // MARK: - External Dependencies

    weak var resultHandler: DebtorsDataNetworkResultHandler?

    private let taskNetworkClient: TaskNetworkClientProtocol
    private let debtorsNetworkClient: DebtorsNetworkClientProtocol
    private let statusNetworkClient: StatusNetworkClientProtocol
    private let throttler: ThrottlerProtocol

    // MARK: - Lifecycle

    init(
        taskNetworkClient: TaskNetworkClientProtocol = TaskNetworkClient(),
        debtorsNetworkClient: DebtorsNetworkClientProtocol = DebtorsNetworkClient(),
        statusNetworkClient: StatusNetworkClientProtocol = StatusNetworkClient(),
        throttler: ThrottlerProtocol = Throttler(minimumDelay: 0.5)
    ) {
        self.taskNetworkClient = taskNetworkClient
        self.debtorsNetworkClient = debtorsNetworkClient
        self.statusNetworkClient = statusNetworkClient
        self.throttler = throttler

        self.taskNetworkClient.resultHandler = self
        self.debtorsNetworkClient.resultHandler = self
        self.statusNetworkClient.resultHandler = self
    }

    // MARK: - Public Functions

    func fetchData(
        forFirstName firstName: String,
        withLastName lastName: String,
        andSecondaryName secondaryName: String,
        andBirthday birthday: String
    ) {
        taskNetworkClient.fetchTask(
            forFirstName: firstName,
            withLastName: lastName,
            andSecondaryName: secondaryName,
            andBirthday: birthday
        )
    }

    // MARK: - TaskNetworkClientResultHandler Conformance

    func taskRequestDidFailed(_ error: Error) {
        resultHandler?.debtorsDataRequestDidFailed(error)
    }

    func taskRequestDidSucceed(_ task: String) {
        checkStatusForTask(task)
    }

    // MARK: - TaskNetworkClientResultHandler Conformance

    func debtorsRequestDidFailed(_ error: Error) {
        resultHandler?.debtorsDataRequestDidFailed(error)
    }

    func debtorsRequestDidSucceed(_ debtors: [Debtor]) {
        resultHandler?.debtorsDataRequestDidSucceed(debtors)
    }

    // MARK: - StatusNetworkClientResultHandler Conformance

    func statusRequestDidFailed(_ error: Error) {
        resultHandler?.debtorsDataRequestDidFailed(error)
    }

    func statusRequestDidSucceed(_ status: TaskStatus, task: String) {
        switch status {
        case .complete, .completeWithError:
            debtorsNetworkClient.fetchDebtorsForTask(task)
        case .didNotStarted, .started:
            checkStatusForTask(task)
        }
    }

    // MARK: - Private Functions

    func checkStatusForTask(_ task: String) {
        throttler.throttle {
            self.statusNetworkClient.fetchStatusForTask(task)
        }
    }
}
