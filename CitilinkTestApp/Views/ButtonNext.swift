//
//  ButtonNext.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct ButtonNext: View {
    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @Binding var isLoading: Bool
    var action: () -> Void

    // MARK: - Body

    var body: some View {
        if !isLoading {
            return AnyView(Button(action: { self.action() }, label: { Text(stringProvider.next) }))
        } else {
            return AnyView(ActivityIndicator(isAnimating: $isLoading, style: .medium, color: .black))
        }
    }
}

struct ButtonNext_Previews: PreviewProvider {
    @State static var isLoading: Bool = false

    static var previews: some View {
        ButtonNext(isLoading: $isLoading) {}
            .environmentObject(LocalizedStringProvider())
    }
}
