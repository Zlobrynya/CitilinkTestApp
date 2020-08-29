//
//  Settings.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol SettingsProtocol {
    var isOnlyCyrillic: Bool { get }
    var isRequiredFieldBirthday: Bool { get }
    
    func update(isOnlyCyrillic: Bool, isRequiredFieldBirthday: Bool)
}

struct Settings: SettingsProtocol  {
    
    // MARK: - Public Properties
    
    var isOnlyCyrillic: Bool { userDefaults.bool(forKey: keys.isOnlyCyrillicKey) }

    var isRequiredFieldBirthday: Bool { userDefaults.bool(forKey: keys.isRequiredFieldBirthdayKey) }

    // MARK: - External Dependencies
    
    private let userDefaults: UserDefaults
    private let keys: SettingsKeysProtocol
    
    // MARK: - Lifecycle

    init(userDefaults: UserDefaults = UserDefaults.standard, keys: SettingsKeysProtocol = SettingsKeys()) {
        self.userDefaults = userDefaults
        self.keys = keys
    }
    
    // MARK: - Public Functions
    
    func update(isOnlyCyrillic: Bool, isRequiredFieldBirthday: Bool) {
        userDefaults.set(isOnlyCyrillic, forKey: keys.isOnlyCyrillicKey)
        userDefaults.set(isRequiredFieldBirthday, forKey: keys.isRequiredFieldBirthdayKey)
    }
    
}
