//
//  UIApplication.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// Causes the view (or one of its embedded text fields) to resign the first responder status.
    ///
    /// - Parameter force: Specify true to force the first responder to resign, regardless of whether it wants to do so.
    func endEditing(_ force: Bool) {
        windows
            .first(where: { $0.isKeyWindow })?
            .endEditing(force)
    }
}
