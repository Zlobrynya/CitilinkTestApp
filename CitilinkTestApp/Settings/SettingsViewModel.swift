//
//  SettingsViewModel.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var isOnlyCyrillic: Bool { didSet { update() } }
    @Published var isRequiredFieldBirthdayKey: Bool  { didSet { update() } }

    // MARK: - External Dependencies

    private let settings: SettingsProtocol

    // MARK: - Lifecycle

    init(settings: SettingsProtocol = Settings()) {
        self.settings = settings
        isRequiredFieldBirthdayKey = settings.isRequiredFieldBirthday
        isOnlyCyrillic = settings.isOnlyCyrillic
    }

    // MARK: - Private Functions

    private func update() {
        settings.update(
            isOnlyCyrillic: isOnlyCyrillic,
            isRequiredFieldBirthday: isRequiredFieldBirthdayKey
        )
    }
}
