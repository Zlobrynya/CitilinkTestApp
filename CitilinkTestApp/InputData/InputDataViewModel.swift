//
//  InputDataViewModel.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

final class InputDataViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var firstName: String = "" { didSet { checkFirstName() } }
    @Published var lastName: String = "" { didSet { checkLastName() } }
    @Published var secondName: String = "" { didSet { checkSecondName() } }

    @Published var birthDate = Date() { didSet { messageBirthDate = dateFormatter.string(from: birthDate) } }
    @Published var messageBirthDate = ""

    @Published var isLoading = false
    @Published var isEnabled = false

    @Published var errorFirstName: Bool = false
    @Published var errorLastName: Bool = false
    @Published var errorSecondName: Bool = false
    
    // MARK: - External Dependencies
    
    let dateFormatter: DateFormatter

    // MARK: - Lifecycle

    init(dateFormatter: DateFormatter = DateFormatter()) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        self.dateFormatter = dateFormatter
    }

    // MARK: - Private Functions

    private func checkFirstName() {
        guard !firstName.isEmpty else {
            errorFirstName = false
            return
        }
        errorFirstName = !firstName.invalidedName(onlyK: true)
    }

    private func checkLastName() {
        guard !lastName.isEmpty else {
            errorLastName = false
            return
        }
        errorLastName = !lastName.invalidedName(onlyK: true)
    }

    private func checkSecondName() {
        guard !secondName.isEmpty else {
            errorSecondName = false
            return
        }
        errorSecondName = !secondName.invalidedName(onlyK: true)
    }
}
