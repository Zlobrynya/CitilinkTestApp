//
//  Data.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol DataParamsProtocol: Encodable {
    var token: String { get }
    var region: String { get }
    var firstName: String { get }
    var secondName: String { get }
    var lastName: String { get }
    var birthdate: String { get }
}

struct DataParams: DataParamsProtocol {
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case secondName = "secondname"
        case lastName = "lastname"
        case token
        case region
        case birthdate
    }
    
    // MARK: - Public Properties
    
    let token: String
    let region: String
    let firstName: String
    let secondName: String
    let lastName: String
    let birthdate: String
}


