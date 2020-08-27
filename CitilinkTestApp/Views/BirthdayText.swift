//
//  BirthdayText.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct BirthdayText: View {
    var textWithPlaceholder: Text {
        if text.isEmpty {
            return Text(stringProvider.birthdatePlaceholder)
                .foregroundColor(.clearButton)
        } else {
            return Text(text)
        }
    }

    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @Binding var text: String

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stringProvider.birthdate)
            textWithPlaceholder
        }
        .padding([.horizontal], 16)
    }
}

struct BirthdayText_Previews: PreviewProvider {
    @State static var text: String = ""
    @State static var error: Bool = false

    static var previews: some View {
        BirthdayText(text: $text)
            .environmentObject(LocalizedStringProvider())
    }
}
