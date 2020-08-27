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
    
    var selectBirthdate: String {
        NSLocalizedString("selectBirthdate", bundle: .main, comment: "")
    }

}

public class LocalizedStringProvider: LocalizedStringProviderProtocol, ObservableObject {
    public init() {}
}
