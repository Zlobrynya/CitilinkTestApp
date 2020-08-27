//
//  NetworkConstants.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol NetworkConstantsProtocol {
    var api: String { get }
    var token: String { get }
}

struct NetworkConstants: NetworkConstantsProtocol {
    var api: String = ""
    var token: String = ""
}
