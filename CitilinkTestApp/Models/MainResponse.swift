//
//  MainResponse.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

//import Foundation
//
//struct MainResponse: Decodable {
//    let response: Response
//}

import Foundation

// MARK: - MainResponse
struct MainResponse: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let result: [ResponseResult]
}

// MARK: - ResponseResult
struct ResponseResult: Codable {
    let result: [Debtor]
}
