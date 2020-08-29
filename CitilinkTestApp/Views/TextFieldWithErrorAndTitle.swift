//
//  TextFieldWithError.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct TextFieldWithError: View {
    // MARK: - View

    var errorView: Text? {
        guard isError else { return nil }
        return Text(errorMessage).foregroundColor(.red)
    }

    // MARK: - External Dependencies

    @Binding var text: String
    var title: String
    var placeholder: String
    var errorMessage: String
    var isError: Bool
    var isActive: Bool = false

    // MARK: - Body

    var body: some View {
        Section(header: Text(title).bold()) {
            TextFieldView(text: $text, placeholder: placeholder)
            errorView
        }
    }
}

struct TextFieldWithError_Previews: PreviewProvider {
    @State static var text: String = ""
    static var error: Bool = false

    static var previews: some View {
        TextFieldWithError(
            text: $text,
            title: "Name",
            placeholder: "Placeholder",
            errorMessage: "errorMessage",
            isError: error
        )
    }
}
