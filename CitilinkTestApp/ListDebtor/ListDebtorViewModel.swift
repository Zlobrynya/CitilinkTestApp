//
//  ListDebtorViewModel.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

final class ListDebtorViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var shouldOpenDebtorsInformation = false
    @Published var debtors: [Debtor] = []
    var selectDebtor: Debtor? { didSet { shouldOpenDebtorsInformation = true } }

    // MARK: - Lifecycle
    
    init(debtors: [Debtor]) {
        self.debtors = debtors
    }
}
