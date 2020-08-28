//
//  Log.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

class Log {
    static func error(_ message: Any) {
        print("🔴 \(message)")
    }
    
    static func debug(_ message: Any) {
        print("🔵 \(message)")
    }
}
