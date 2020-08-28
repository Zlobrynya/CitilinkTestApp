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
        Form {
            TextFieldWithError(
                text: $viewModel.lastName,
                title: stringProvider.lastName,
                placeholder: stringProvider.lastNamePlaceholder,
                errorMessage: stringProvider.lastNameError,
                isError: $viewModel.errorLastName
            )
            TextFieldWithError(
                text: $viewModel.firstName,
                title: stringProvider.firstName,
                placeholder: stringProvider.firstNamePlaceholder,
                errorMessage: stringProvider.firstNameError,
                isError: $viewModel.errorFirstName
            )
            TextFieldWithError(
                text: $viewModel.secondName,
                title: stringProvider.secondaryName,
                placeholder: stringProvider.firstNamePlaceholder,
                errorMessage: stringProvider.secondaryNameError,
                isError: $viewModel.errorSecondName
            )
            BirthdayText(birthDate: $viewModel.birthDate, withDate: $viewModel.withDate)
        }
    }

    var button: some View {
        guard !shouldShowDatePicker else { return AnyView(EmptyView()) }
        return AnyView(VStack {
            Spacer()
            ButtonNext(isEnabled: viewModel.isEnabled, isLoading: $viewModel.isLoading) {
                self.viewModel.fetchData()
            }
        })
    }

    // MARK: - External Dependencies

    @EnvironmentObject private var stringProvider: LocalizedStringProvider
    @ObservedObject var viewModel: InputDataViewModel
    @State private var birthDate = Date()
    @State var shouldShowDatePicker = false
    @State var isKeyboardShow = false

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: ListDebtorView(viewModel: ListDebtorViewModel(debtors: viewModel.debtors)),
                    isActive: $viewModel.shouldPresentDebtor,
                    label: { EmptyView() }
                )
                textFields
                button
            }
            .allowsHitTesting(isKeyboardShow)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                    .receive(on: RunLoop.main),
                perform: updateKeyboardHeight
            )
            .navigationBarTitle("", displayMode: .inline)
        }
    }

    // MARK: - Private Functions

    private func updateKeyboardHeight(_: Foundation.Notification) {
        isKeyboardShow = !isKeyboardShow
    }
}

struct InputDataView_Previews: PreviewProvider {
    static var previews: some View {
        InputDataView(viewModel: InputDataViewModel())
            .environmentObject(LocalizedStringProvider())
    }
}
