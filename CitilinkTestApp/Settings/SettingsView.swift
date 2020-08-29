//
//  SettingsView.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @ObservedObject var viewModel: SettingsViewModel
    @Binding var shouldOpenSettings: Bool
    

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(
                    action: { self.shouldOpenSettings.toggle() },
                    label: { Text(stringProvider.back) }
                )
            }
            .padding(14)
            Form {
                Section {
                    Toggle(isOn: $viewModel.isOnlyCyrillic) {
                        Text(stringProvider.onlyCyrillic)
                    }
                }
                Section {
                    Toggle(isOn: $viewModel.isRequiredFieldBirthdayKey) {
                        Text(stringProvider.requiredFieldBirthday)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var shouldOpenSettings = false

    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(), shouldOpenSettings: $shouldOpenSettings)
            .environmentObject(LocalizedStringProvider())
    }
}
