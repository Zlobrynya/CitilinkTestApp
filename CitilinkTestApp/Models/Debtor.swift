//
//  Debtor.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol DebtorProtocol: Decodable {
    var name: String { get }
    var production: String { get }
    var details: String { get }
    var subject: String { get }
    var department: String { get }
    var bailiff: String { get }
}

struct Debtor: DebtorProtocol {
    enum CodingKeys: String, CodingKey {
        case production = "exe_production"
        case subject
        case name
        case details
        case department
        case bailiff
    }

    // MARK: - Public Properties

    let name: String
    let production: String
    let details: String
    let subject: String
    let department: String
    let bailiff: String

    // MARK: - Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        production = try container.decode(String.self, forKey: .production)
        subject = try container.decode(String.self, forKey: .subject)
        details = try container.decode(String.self, forKey: .details)
        department = try container.decode(String.self, forKey: .department)
        bailiff = try container.decode(String.self, forKey: .bailiff)
    }
}
