//
//  InfoDebtorSection.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct InfoDebtorSection: View {
    // MARK: - External Dependencies

    var title: String
    var text: String

    // MARK: - Body

    var body: some View {
        Section(header: Text(title).bold()) {
            Text(text)
        }
    }
}

struct InfoDebtorSection_Previews: PreviewProvider {
    static var previews: some View {
        InfoDebtorSection(title: "Title", text: "Test")
    }
}
