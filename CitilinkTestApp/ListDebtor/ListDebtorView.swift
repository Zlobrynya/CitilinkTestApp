//
//  ListDebtorView.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

struct ListDebtorView: View {
    
    // MARK: - External Dependencies

    @ObservedObject var viewModel: ListDebtorViewModel

    // MARK: - Body

    var body: some View {
        ScrollView {
            ForEach(viewModel.debtors, id: \.production) { item in
                Button(
                    action: {
                        self.viewModel.selectDebtor = item
                    },
                    label: {
                        VStack {
                            Divider()
                            Text(item.production)
                                .multilineTextAlignment(.center)
                                .padding([.horizontal], 16)
                        }
                    }
                )
            }
        }
        .sheet(isPresented: $viewModel.shouldOpenDebtorsInformation) {
            InfoDebtorView(
                debtor: self.viewModel.selectDebtor,
                shouldOpenDebtorsInformation: self.$viewModel.shouldOpenDebtorsInformation
            )
            .environmentObject(LocalizedStringProvider())
        }
    }
}

struct ListDebtorView_Previews: PreviewProvider {
    static var debtors = MockListDebtorViewModel().debtors

    static var previews: some View {
        ListDebtorView(viewModel: ListDebtorViewModel(debtors: debtors))
    }
}
