//
//  MainResponseTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

@testable import CitilinkTestApp
import Foundation
import XCTest

class MainResponseTest: XCTestCase {

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
        // WHEN

        let mainResponse = try JsonObject<MainResponse>(
            fileName: "MockDebtors",
            decoder: decoder,
            bundle: Bundle(for: type(of: self))
        ).decodedItem

        // THEN
        
        XCTAssertFalse(mainResponse.response.result.first!.result.isEmpty)
    }
}
