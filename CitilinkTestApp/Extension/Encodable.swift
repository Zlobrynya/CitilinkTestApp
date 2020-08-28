//
//  Encodable.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

extension Encodable {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    /// - Returns: <#Returns Description#>
    func asURLQueryItem(jsonEncoder: JSONEncoder) throws -> [URLQueryItem] {
        let data = try jsonEncoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
            throw NSError()
        }
        var queryItems = [URLQueryItem]()
        dictionary.forEach {
            let item = URLQueryItem(name: $0, value: $1)
            queryItems.append(item)
        }
        return queryItems
    }
}
