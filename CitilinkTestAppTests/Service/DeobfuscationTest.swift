//
//  DeobfuscationTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import XCTest
@testable import CitilinkTestApp

class DeobfuscationTest: XCTestCase {
    
    // MARK: - SUT
    
    var sut: Deobfuscation!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        sut = Deobfuscation()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Functions

    func test_reveal_key_deobfuscationСorrectly() {
        // GIVEN
        
        let key: [UInt8] = [21, 21, 3, 48, 49, 9, 22, 19, 64, 85]
        
        // WHEN
        
        let message = sut.reveal(key: key)
        
        // THEN
        
        let mockMessage = "TestTest!!"
        
        XCTAssertEqual(message, mockMessage)
        
    }
    
}
