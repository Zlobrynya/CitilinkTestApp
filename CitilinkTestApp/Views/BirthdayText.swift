//
//  BirthdayText.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct BirthdayText: View {
    private var clearButton: some View {
        HStack {
            Spacer()
            Button(
                action: {
                    self.withDate = false
                },
                label: {
                    Text("Clear")
                }
            )
            Spacer()
        }
    }

    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @Binding var birthDate: Date
    @Binding var withDate: Bool

    // MARK: - Body

    var body: some View {
        Section(header: Text(stringProvider.birthdate).bold()) {
            if withDate {
                clearButton
                DatePicker(stringProvider.birthdatePlaceholder, selection: $birthDate, displayedComponents: .date)
                    .padding()

            } else {
                Button(
                    action: { self.withDate = true },
                    label: {
                        Text(stringProvider.birthdatePlaceholder)
                    }
                )
                .foregroundColor(.secondaryColor)
            }
        }
    }
}

struct BirthdayText_Previews: PreviewProvider {
    @State static var birthDate = Date()
    @State static var withDate = false

    static var previews: some View {
        BirthdayText(birthDate: $birthDate, withDate: $withDate)
            .environmentObject(LocalizedStringProvider())
    }
}
