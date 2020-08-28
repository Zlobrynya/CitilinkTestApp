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

    @Published var firstName: String = "" { didSet { checkFirstName() } }
    @Published var lastName: String = "" { didSet { checkLastName() } }
    @Published var secondName: String = "" { didSet { checkSecondName() } }

    @Published var birthDate = Date() { didSet { messageBirthDate = dateFormatter.string(from: birthDate) } }
    @Published var messageBirthDate = ""

    @Published var isLoading = false
    @Published var isEnabled = false
    @Published var shouldPresentDebtor = false
    @Published var withDate = false

    @Published var errorFirstName: Bool = false
    @Published var errorLastName: Bool = false
    @Published var errorSecondName: Bool = false
    
    var debtors: [Debtor] = []
    
    // MARK: - External Dependencies
    
    private let dateFormatter: DateFormatter
    private let debtorsDataNetworkClient: DebtorsDataNetworkClientProtocol
    
    // MARK: - Lifecycle

    init(
        dateFormatter: DateFormatter = DateFormatter(),
        debtorsDataNetworkClient: DebtorsDataNetworkClientProtocol = DebtorsDataNetworkClient()
    ) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        self.dateFormatter = dateFormatter
        self.debtorsDataNetworkClient = debtorsDataNetworkClient
        self.debtorsDataNetworkClient.resultHandler = self
    }
    
    // MARK: - Public Functions

    func fetchData() {
        debtorsDataNetworkClient.fetchData(
            forFirstName: firstName,
            withLastName: lastName,
            andSecondaryName: secondName,
            andBirthday: messageBirthDate
        )
    }
    
    // MARK: - DebtorsDataNetworkResultHandler Conformance

    
    func debtorsDataRequestDidFailed(_ error: Error) {
        Log.error(error)
    }
    
    func debtorsDataRequestDidSucceed(_ debtors: [Debtor]) {
        self.debtors = debtors
        DispatchQueue.main.async {
            self.shouldPresentDebtor = true
        }
    }

    // MARK: - Private Functions

    private func checkFirstName() {
        guard !firstName.isEmpty else {
            errorFirstName = false
            return
        }
        errorFirstName = !firstName.invalidedName(onlyCyrillic: true)
    }

    private func checkLastName() {
        guard !lastName.isEmpty else {
            errorLastName = false
            return
        }
        errorLastName = !lastName.invalidedName(onlyCyrillic: true)
    }

    private func checkSecondName() {
        guard !secondName.isEmpty else {
            errorSecondName = false
            return
        }
        errorSecondName = !secondName.invalidedName(onlyCyrillic: true)
    }
}
