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
    var isEnabled: Bool
    @Binding var isLoading: Bool
    var action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(
            action: {
                self.action()
            },
            label: {
                if !isLoading {
                    Text("Next")
                        .padding([.vertical], 16)
                        .padding([.horizontal], 24)
                        .background(isEnabled ? Color.gray : Color.green)
                        .cornerRadius(15)
                } else {
                    ActivityIndicator(isAnimating: $isLoading, style: .medium, color: .white)
                        .padding([.vertical], 16)
                        .padding([.horizontal], 24)
                        .background(isEnabled ? Color.gray : Color.green)
                        .cornerRadius(15)
                }

            }
        )
        .foregroundColor(.white)
    }
}

struct ButtonNext_Previews: PreviewProvider {
    @State static var isLoading: Bool = true

    static var previews: some View {
        ButtonNext(isEnabled: false, isLoading: $isLoading) {}
            .environmentObject(LocalizedStringProvider())
    }
}
