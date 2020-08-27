//
//  String.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

extension String {
    
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func invalidedName(onlyK: Bool) -> Bool {
        let urlRegEx = onlyK ? "^[а-яА-ЯёЁ]{1,20}$" : "^[а-яА-ЯёЁa-zA-Z]{1,25}$"
        return (self.range(of: urlRegEx, options:.regularExpression) != nil)
    }
    
}
