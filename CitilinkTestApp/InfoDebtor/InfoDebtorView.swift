//
//  InfoDebtor.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct InfoDebtorView: View {
    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @Binding var shouldOpenDebtorsInformation: Bool
    var debtor: Debtor

    // MARK: - Lifecycle

    init?(debtor: Debtor?, shouldOpenDebtorsInformation: Binding<Bool>) {
        guard let debtor = debtor else { return nil }
        self.debtor = debtor
        _shouldOpenDebtorsInformation = shouldOpenDebtorsInformation
    }

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(
                    action: { self.shouldOpenDebtorsInformation.toggle() },
                    label: { Text(stringProvider.back) }
                )
            }
            .padding(14)
            Form {
                InfoDebtorSection(title: stringProvider.debtorName, text: debtor.name)
                InfoDebtorSection(title: stringProvider.debtorProduction, text: debtor.production)
                InfoDebtorSection(title: stringProvider.debtorDetails, text: debtor.details)
                InfoDebtorSection(title: stringProvider.debtorSubject, text: debtor.subject)
                InfoDebtorSection(title: stringProvider.debtorDepartment, text: debtor.department)
                InfoDebtorSection(title: stringProvider.debtorBailiff, text: debtor.bailiff)
            }
        }
    }
}

struct InfoDebtorView_Previews: PreviewProvider {
    static var debtor = MockListDebtorViewModel().debtors.first
    @State static var shouldOpenDebtorsInformation = false

    static var previews: some View {
        InfoDebtorView(debtor: debtor, shouldOpenDebtorsInformation: $shouldOpenDebtorsInformation)
            .environmentObject(LocalizedStringProvider())
    }
}
