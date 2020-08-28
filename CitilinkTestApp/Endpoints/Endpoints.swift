//
//  Endpoints.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol EndpointsProtocol: Codable {
    var api: String { get }
    var physical: String { get }
    var result: String { get }
    var status: String { get }
}

struct Endpoints: EndpointsProtocol {
    var api: String
    var physical: String
    var result: String
    var status: String
}
