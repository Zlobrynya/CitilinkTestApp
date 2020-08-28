//
//  DIContainer.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

/// Container which holds single instances for all classes that should only exist once.
enum DIContainer {
    /// Endpoints needed by the Core module.
    static let endpoints = Plist<Endpoints>(resourceName: "Endpoints", bundle: .main).decode()!
    /// External Key needed by the Core module.
    static let apiKeys = Plist<ApiKeys>(resourceName: "ApiKeys", bundle: .main).decode()!
}
