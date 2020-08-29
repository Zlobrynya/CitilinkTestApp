//
//  TaskMainResponseTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

@testable import CitilinkTestApp
import Foundation
import XCTest

class TaskMainResponseTest: XCTestCase {

    // MARK: - Dependencies
    
    private let decoder = JSONDecoder()

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test Functions

    func test_initFromDecoder_withJson_allPropertiesAreDecodedCorrectly() throws {
        // GIVEN
        
        let task = "957c172d-8711-4002-a07e-dbccbddced43"
        
        // WHEN

        let taskMainResponse = try JsonObject<TaskMainResponse>(
            fileName: "MockGet",
            decoder: decoder,
            bundle: Bundle(for: type(of: self))
        ).decodedItem

        // THEN
        
        XCTAssertEqual(task, taskMainResponse.response.task)
    }
}
