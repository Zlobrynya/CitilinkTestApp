//
//  InputDataViewModel.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

final class InputDataViewModel: ObservableObject, DebtorsDataNetworkResultHandler {
    // MARK: - Public Properties

    @Published var firstName = "" { didSet { checkEnabled() } }
    @Published var lastName = "" { didSet { checkEnabled() } }
    @Published var secondName = "" { didSet { checkEnabled() } }

    @Published var birthDate = Date()

    @Published var isLoading = false
    @Published var isEnabled = false
    @Published var shouldPresentDebtor = false
    @Published var withDate = false

    @Published var shouldShowAlert = false
    @Published var alertMessage = "" { didSet { shouldShowAlert = true } }

    var debtors: [Debtor] = []

    // MARK: - External Dependencies

    private let dateFormatter: DateFormatter
    private let debtorsDataNetworkClient: DebtorsDataNetworkClientProtocol
    private let stringProvider: LocalizedStringProviderProtocol

    // MARK: - Lifecycle

    init(
        dateFormatter: DateFormatter = DateFormatter(),
        debtorsDataNetworkClient: DebtorsDataNetworkClientProtocol = DebtorsDataNetworkClient(),
        stringProvider: LocalizedStringProviderProtocol = LocalizedStringProvider()
    ) {
        dateFormatter.dateFormat = "dd.MM.YYYY"
        self.dateFormatter = dateFormatter
        self.debtorsDataNetworkClient = debtorsDataNetworkClient
        self.stringProvider = stringProvider
        self.debtorsDataNetworkClient.resultHandler = self
    }

    // MARK: - Public Functions

    func fetchData() {
        isLoading = true
        debtorsDataNetworkClient.fetchData(
            forFirstName: firstName,
            withLastName: lastName,
            andSecondaryName: secondName,
            andBirthday: withDate ? dateFormatter.string(from: birthDate) : ""
        )
    }
    
    func checkName(_ name: String) -> Bool {
        guard !name.isEmpty else { return false }
        return !name.invalidedName(onlyCyrillic: true)
    }

    // MARK: - DebtorsDataNetworkResultHandler Conformance

    func debtorsDataRequestDidFailed(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.alertMessage = self.stringProvider.somethingWrong
        }
        Log.error(error)
    }

    func debtorsDataRequestDidSucceed(_ debtors: [Debtor]) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.debtors = debtors
            if self.debtors.isEmpty {
                self.alertMessage = self.stringProvider.debtorsNotFound
            } else {
                self.shouldPresentDebtor = true
            }
        }
    }
    
    // MARK: - Private Functions

    private func checkEnabled() {
        isEnabled = lastName.invalidedName(onlyCyrillic: true) &&
            firstName.invalidedName(onlyCyrillic: true) &&
            secondName.invalidedName(onlyCyrillic: true)
    }
}
