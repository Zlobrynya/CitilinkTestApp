//
//  StringTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

@testable import CitilinkTestApp
import Foundation
import XCTest

class StringTest: XCTestCase {
    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test Functions

    func test_validateName_withStringOnlyCyrillic_stringPassedVerification() {
        // GIVEN

        let strOnlyCyrillic = "ТестТЕст"

        // WHEN

        let isValidate = strOnlyCyrillic.validateName(onlyCyrillic: true)

        // THEN

        XCTAssertTrue(isValidate)
    }

    func test_validateName_withStringNotOnlyCyrillic_stringDidNotPassedVerification() {
        // GIVEN

        let strNotOnlyCyrillic = "ТестТЕстvgdfdfgdf"

        // WHEN

        let isValidate = strNotOnlyCyrillic.validateName(onlyCyrillic: true)

        // THEN

        XCTAssertFalse(isValidate)
    }

    func test_validateName_withStringConstainNumberAndCyrillic_stringDidNotPassedVerification() {
        // GIVEN

        let strNotOnlyCyrillic = "теукые132121"

        // WHEN

        let isValidate = strNotOnlyCyrillic.validateName(onlyCyrillic: true)

        // THEN

        XCTAssertFalse(isValidate)
    }

    func test_toUInt8_withArrayNumberAsString_stringWasConvertedToArrayCorrectly() {
        // GIVEN

        let arrayNumberAsString = "[1, 3, 4, 6]"

        // WHEN

        let array = arrayNumberAsString.toUInt8()

        // THEN

        let mockArrayNumber: [UInt8] = [1, 3, 4, 6]

        XCTAssertEqual(array, mockArrayNumber)
    }
}
