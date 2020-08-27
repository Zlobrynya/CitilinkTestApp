//
//  MockListDebtorViewModel.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

final class MockListDebtorViewModel: ObservableObject {
    
    var debtors: [Debtor] = []
    
    init() {
        debtors = try! JsonObject<MainResponse>(fileName: "Debtors").decodedItem.response.result.first!.result
    }
}
