//
//  LocalizedStringProvider.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol LocalizedStringProviderProtocol {}

extension LocalizedStringProviderProtocol {
    // MARK: - Input Data View

    var lastName: String {
        NSLocalizedString("lastName", comment: "")
    }

    var firstName: String {
        NSLocalizedString("firstName", bundle: .main, comment: "")
    }

    var secondaryName: String {
        NSLocalizedString("secondaryName", bundle: .main, comment: "")
    }

    var lastNamePlaceholder: String {
        NSLocalizedString("lastNamePlaceholder", bundle: .main, comment: "")
    }

    var firstNamePlaceholder: String {
        NSLocalizedString("firstNamePlaceholder", bundle: .main, comment: "")
    }
    
    var secondaryNamePlaceholder: String {
        NSLocalizedString("secondaryNamePlaceholder", bundle: .main, comment: "")
    }

    var lastNameError: String {
        NSLocalizedString("lastNameError", bundle: .main, comment: "")
    }

    var firstNameError: String {
        NSLocalizedString("firstNameError", bundle: .main, comment: "")
    }

    var secondaryNameError: String {
        NSLocalizedString("secondaryNameError", bundle: .main, comment: "")
    }

    var birthdate: String {
        NSLocalizedString("birthdate", bundle: .main, comment: "")
    }

    var birthdatePlaceholder: String {
        NSLocalizedString("birthdatePlaceholder", bundle: .main, comment: "")
    }

    // MARK: - Debtor's informations.

    var debtorProduction: String {
        NSLocalizedString("debtorProduction", bundle: .main, comment: "")
    }

    var debtorName: String {
        NSLocalizedString("debtorName", bundle: .main, comment: "")
    }

    var debtorDetails: String {
        NSLocalizedString("debtorDetails", bundle: .main, comment: "")
    }

    var debtorSubject: String {
        NSLocalizedString("debtorSubject", bundle: .main, comment: "")
    }

    var debtorDepartment: String {
        NSLocalizedString("debtorDepartment", bundle: .main, comment: "")
    }

    var debtorBailiff: String {
        NSLocalizedString("debtorBailiff", bundle: .main, comment: "")
    }

    var debtorsNotFound: String {
        NSLocalizedString("debtorsNotFound", bundle: .main, comment: "")
    }

    // MARK: - General.

    var back: String {
        NSLocalizedString("back", bundle: .main, comment: "")
    }

    var find: String {
        NSLocalizedString("find", bundle: .main, comment: "")
    }
    // MARK: - Error

    var somethingWrong: String {
        NSLocalizedString("somethingWrong", bundle: .main, comment: "")
    }
    
    // MARK: - Settings

    var onlyCyrillic: String {
        NSLocalizedString("onlyCyrillic", bundle: .main, comment: "")
    }
    
    var requiredFieldBirthday: String {
        NSLocalizedString("requiredFieldBirthday", bundle: .main, comment: "")
    }
}

public class LocalizedStringProvider: LocalizedStringProviderProtocol, ObservableObject {
    public init() {}
}
