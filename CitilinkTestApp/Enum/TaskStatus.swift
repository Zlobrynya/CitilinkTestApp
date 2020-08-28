//
//  TaskStatus.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

enum TaskStatus: Int {
    case complete = 0
    case started
    case didNotStarted
    case completeWithError
}
