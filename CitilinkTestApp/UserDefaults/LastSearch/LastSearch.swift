//
//  LastSearch.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol LastSearchProtocol {
    var lastName: String { get }
    var firstName: String { get }
    var secondName: String { get }
    var birthday: String { get }

    ///  Updates information about the last search
    ///
    /// - Parameter lastName: Debtor's last name.
    /// - Parameter firstName: Debtor's first name.
    /// - Parameter secondName: Debtor's second name.
    /// - Parameter birthday: Debtor's birthday.
    func update(lastName: String, firstName: String, secondName: String, birthday: String)
}

struct LastSearch: LastSearchProtocol {
    // MARK: - Public Properties

    var lastName: String { userDefaults.string(forKey: keys.lastNameKey) ?? "" }
    var firstName: String { userDefaults.string(forKey: keys.firstNameKey) ?? "" }
    var secondName: String { userDefaults.string(forKey: keys.secondNameKey) ?? "" }
    var birthday: String { userDefaults.string(forKey: keys.birthdayKey) ?? "" }

    // MARK: - External Dependencies

    private let userDefaults: UserDefaults
    private let keys: LastSearchKeysProtocol

    // MARK: - Lifecycle

    init(userDefaults: UserDefaults = UserDefaults.standard, keys: LastSearchKeysProtocol = LastSearchKeys()) {
        self.userDefaults = userDefaults
        self.keys = keys
    }

    // MARK: - Public Functions

    func update(lastName: String, firstName: String, secondName: String, birthday: String) {
        userDefaults.set(lastName, forKey: keys.lastNameKey)
        userDefaults.set(firstName, forKey: keys.firstNameKey)
        userDefaults.set(secondName, forKey: keys.secondNameKey)
        userDefaults.set(birthday, forKey: keys.birthdayKey)
    }
}
