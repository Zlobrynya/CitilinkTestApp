//
//  InputDataConstants.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

protocol InputDataConstantsProtocol {
    var token: String { get }
    var physical: String { get }
    var result: String { get }
    var status: String { get }
    var region: String { get }
}

struct InputDataConstants: InputDataConstantsProtocol {
    // MARK: - Public Properties

    var token: String
    var physical: String
    var result: String
    var status: String
    var region = "10"

    // MARK: - Lifecycle

    init(
        endpoints: EndpointsProtocol = DIContainer.endpoints,
        apiKeys: ApiKeysProtocol = DIContainer.apiKeys,
        deobfuscation: DeobfuscationProtocol = Deobfuscation()
    ) {
        self.token = deobfuscation.reveal(key: apiKeys.token.toUInt8())
        let api = deobfuscation.reveal(key: endpoints.api.toUInt8())
        physical = api + deobfuscation.reveal(key: endpoints.physical.toUInt8())
        result = api + deobfuscation.reveal(key: endpoints.result.toUInt8())
        status = api + deobfuscation.reveal(key: endpoints.status.toUInt8())
    }
}
