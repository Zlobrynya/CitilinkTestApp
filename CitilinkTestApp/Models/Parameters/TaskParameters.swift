//
//  Data.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

struct TaskParameters: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
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


