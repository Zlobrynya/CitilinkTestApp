//
//  InputDataView.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct InputDataView: View {
    // MARK: - Views

    var textFields: some View {
        VStack(alignment: .leading) {
            Divider()
            TextFieldWithError(
                text: $viewModel.lastName,
                title: stringProvider.lastName,
                placeholder: stringProvider.lastNamePlaceholder,
                errorMessage: stringProvider.lastNameError,
                isError: $viewModel.errorLastName
            )
            Divider()
            TextFieldWithError(
                text: $viewModel.firstName,
                title: stringProvider.firstName,
                placeholder: stringProvider.firstNamePlaceholder,
                errorMessage: stringProvider.firstNameError,
                isError: $viewModel.errorFirstName
            )
            Divider()
            TextFieldWithError(
                text: $viewModel.secondName,
                title: stringProvider.secondaryName,
                placeholder: stringProvider.firstNamePlaceholder,
                errorMessage: stringProvider.secondaryNameError,
                isError: $viewModel.errorSecondName
            )
            Divider()
            BirthdayText(text: $viewModel.messageBirthDate)
            HStack {
                Spacer()
                DatePicker("", selection: $viewModel.birthDate, in: ...Date(), displayedComponents: .date)
                    .labelsHidden()
                    .padding()
                Spacer()
            }
            Spacer()
        }
    }

    var button: some View {
        guard !shouldShowDatePicker else { return AnyView(EmptyView()) }
        return AnyView(VStack {
            Spacer()
            ButtonNext(isEnabled: viewModel.isEnabled, isLoading: $viewModel.isLoading) {}
        })
    }

    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @ObservedObject var viewModel: InputDataViewModel
    @State private var birthDate = Date()
    @State var shouldShowDatePicker = false

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack {
                textFields
                button
            }.onTapGesture {
                UIApplication.shared.endEditing(true)
            }
        }
    }
}

struct InputDataView_Previews: PreviewProvider {
    static var previews: some View {
        InputDataView(viewModel: InputDataViewModel())
            .environmentObject(LocalizedStringProvider())
    }
}
