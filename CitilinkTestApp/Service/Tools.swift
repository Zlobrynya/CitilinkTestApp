//
//  Tools.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

/// Executes the given block on the queue associated with the main thread of the current process.
///
/// If the current thread is the main thread, then the block will be executed immediately. Otherwise it will be scheduled
/// for execution on the main thread asynchronously.
/// - Parameter block: The block containing the work to perform. This block has no return value and no parameters.
public func executeOnMainQueue(block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}
