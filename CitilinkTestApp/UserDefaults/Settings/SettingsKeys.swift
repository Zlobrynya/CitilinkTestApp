//
//  SettingsKeys.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol SettingsKeysProtocol {
    var isOnlyCyrillicKey: String { get }
    var isRequiredFieldBirthdayKey: String { get }
}

struct SettingsKeys: SettingsKeysProtocol {
    // MARK: - Public Properties

    var isOnlyCyrillicKey = "onlyCyrillicKey"
    var isRequiredFieldBirthdayKey = "requiredFieldBirthdayKey"
}
