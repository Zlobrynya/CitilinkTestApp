//
//  ApiKey.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

public protocol ApiKeysProtocol: Codable {
    var token: String { get }
}

public struct ApiKeys: ApiKeysProtocol {
    public var token: String
}
