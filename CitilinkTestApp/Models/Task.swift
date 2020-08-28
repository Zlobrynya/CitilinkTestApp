//
//  Task.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 28.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import Foundation

struct TaskMainResponse: Codable {
    let response: Task
}

// MARK: - Task
struct Task: Codable {
    let task: String
}
