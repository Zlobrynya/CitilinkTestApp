//
//  MainResponse.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol MainResponseProtocol: Decodable {
    var response: Response { get }
}

struct MainResponse: MainResponseProtocol {
    let response: Response
}
