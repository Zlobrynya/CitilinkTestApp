//
//  Throttler.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

/// Throttler
public protocol ThrottlerProtocol {
    /// Performing throttle
    ///
    /// - Parameter block: Closure to be completed in a 'minimumDelay' time.
    func throttle(_ block: @escaping () -> Void)
}

public class Throttler: ThrottlerProtocol {
    // MARK: - Private Properties

    private var previousRun = Date.distantPast
    
    // MARK: - External Dependencies
    
    private var workItem: DispatchWorkItem
    private let queue: DispatchQueue
    private let minimumDelay: TimeInterval

    // MARK: - Lifecycle
    
    public init(
        minimumDelay: TimeInterval,
        queue: DispatchQueue = DispatchQueue.global(qos: .background),
        workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    ) {
        self.minimumDelay = minimumDelay
        self.queue = queue
        self.workItem = workItem
    }
    
    // MARK: - Public Functions

    public func throttle(_ block: @escaping () -> Void) {
        // Cancel any existing work item if it has not yet executed
        workItem.cancel()

        // Re-assign workItem with the new block task, resetting the previousRun time when it executes
        workItem = DispatchWorkItem { [weak self] in
            self?.previousRun = Date()
            block()
        }

        // If the time since the previous run is more than the required minimum delay
        // => execute the workItem immediately
        // else
        // => delay the workItem execution by the minimum delay time
        let delay = previousRun.timeIntervalSinceNow > minimumDelay ? 0 : minimumDelay
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}
