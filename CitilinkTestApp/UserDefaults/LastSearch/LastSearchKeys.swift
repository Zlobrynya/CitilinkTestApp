//
//  LastSearchKeys.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol LastSearchKeysProtocol {
    var lastNameKey: String { get }
    var firstNameKey: String { get }
    var secondNameKey: String { get }
    var birthdayKey: String { get }
}

struct LastSearchKeys: LastSearchKeysProtocol {
    // MARK: - Public Properties

    var lastNameKey = "lastName"
    var firstNameKey = "firstName"
    var secondNameKey = "secondName"
    var birthdayKey = "birthday"
}
