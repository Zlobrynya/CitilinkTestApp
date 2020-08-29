//
//  String.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

extension String {
    ///  Checking the name for correctness.
    ///
    /// - Parameter onlyCyrillic: Flag for checking only Cyrillic.
    /// - Returns: Test result.
    func validateName(onlyCyrillic: Bool) -> Bool {
        guard !self.isEmpty else { return false }
        let urlRegEx = onlyCyrillic ? "^[а-яА-ЯёЁ]{1,20}$" : "^[а-яА-ЯёЁa-zA-Z]{1,25}$"
        return (range(of: urlRegEx, options: .regularExpression) != nil)
    }

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: Returns Description
    func toUInt8() -> [UInt8] {
        replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: " ", with: "")
            .components(separatedBy: ",")
            .compactMap { UInt8($0) }
    }
}
