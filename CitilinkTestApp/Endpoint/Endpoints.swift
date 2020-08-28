//
//  Endpoints.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

public protocol EndpointsProtocol: Codable {
    var token: String { get }
}

public struct Endpoints: EndpointsProtocol {
    public var token: String
}
