//
//  Status.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

// MARK: - MainResponse
struct StatusMainResponse: Codable {
    let response: Status
}

// MARK: - Response
struct Status: Codable {
    let status: Int
}
