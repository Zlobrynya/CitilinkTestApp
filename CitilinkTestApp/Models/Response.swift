//
//  Response.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol ResponseProtocol: Decodable {
    var result: [Debtor] { get }
}

struct Response: ResponseProtocol {    
    let result: [Debtor]
}
