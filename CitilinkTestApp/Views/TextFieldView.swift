//
//  TextFieldView.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct TextFieldView: View {
    
    // MARK: - Optional Views

    private var clearButton: Button<Image>? {
        guard !text.isEmpty else { return nil }
        return Button(
            action: {
                self.text = ""
            },
            label: {
                Image(systemName: "xmark.circle.fill")
            }
        )
    }
    
    // MARK: - External Dependencies

    @Binding var text: String
    var placeholder: String

    // MARK: - Body

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
            clearButton?.foregroundColor(.secondaryColor)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text: String = "fdsfds"

    static var previews: some View {
        TextFieldView(
            text: $text,
            placeholder: "Placeholder"
        )
    }
}
