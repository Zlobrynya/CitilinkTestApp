//
//  NetworkResult.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

/// Network result
struct NetworkResult {

    /// Result data.
    let data: Data

    /// Result metadata.
    let metadata: HTTPURLResponse?
    
    /// Default initializer for `NetworkResult`.
    ///
    /// - Parameter data: The `Data` of the network result
    /// - Parameter metadata: The `HTTPURLResponse` of the network result
    /// - Returns: Initialized `NetworkResult`
    init(data: Data, metadata: HTTPURLResponse?) {
        self.data = data
        self.metadata = metadata
    }
}

