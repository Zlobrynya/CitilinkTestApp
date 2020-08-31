//
//  SettingsTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import XCTest
import Foundation
@testable import CitilinkTestApp

class SettingsTest: XCTestCase {
    // MARK: - SUT
    
    var sut: Settings!
    
    // MARK: - Dependencies
    
    private var userDefaults: UserDefaults!
    private let keys: SettingsKeysProtocol = SettingsKeys()
    
    // MARK: Constants
    
    private let testBool = true
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults.standard
        sut = Settings(userDefaults: userDefaults, keys: keys)
    }
    
    override func tearDown() {
        userDefaults = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Functions

    func test_isOnlyCyrillic_userDefaultsHasIsOnlyCyrillic_isOnlyCyrillicReceivedCorrectly() {
        // GIVEN
        
        userDefaults.set(testBool, forKey: keys.isOnlyCyrillicKey)
        
        // WHEN
        
        let isOnlyCyrillic = sut.isOnlyCyrillic
        
        // THEN
        
        XCTAssertEqual(isOnlyCyrillic, testBool)
    }
    
    func test_isOnlyCyrillic_userDefaultsHasNotIsOnlyCyrillic_isOnlyCyrillicDefaultValue() {
        // GIVEN
        
        userDefaults.set(nil, forKey: keys.isOnlyCyrillicKey)
        
        // WHEN
        
        let isOnlyCyrillic = sut.isOnlyCyrillic
        
        // THEN
        
        XCTAssertTrue(isOnlyCyrillic)
    }
    
    func test_isRequiredFieldBirthday_userDefaultsHasisRequiredFieldBirthday_isRequiredFieldBirthdayReceivedCorrectly() {
        // GIVEN
        
        userDefaults.set(testBool, forKey: keys.isRequiredFieldBirthdayKey)
        
        // WHEN
        
        let isRequiredFieldBirthday = sut.isRequiredFieldBirthday
        
        // THEN
        
        XCTAssertEqual(isRequiredFieldBirthday, testBool)
    }
    
    func test_isRequiredFieldBirthday_userDefaultsHasNotIsRequiredFieldBirthday_isRequiredFieldBirthdayDefaultValue() {
        // GIVEN

        userDefaults.set(nil, forKey: keys.isRequiredFieldBirthdayKey)
        
        // WHEN
        
        let isRequiredFieldBirthday = sut.isRequiredFieldBirthday
        
        // THEN
        
        XCTAssertFalse(isRequiredFieldBirthday)
    }
    
    func test_update_dataForSave_dataReceivedCorrectly() {
        // GIVEN

        let isOnlyCyrillic = true
        let isRequiredFieldBirthday = true
        
        // WHEN
        
        sut.update(isOnlyCyrillic: isOnlyCyrillic, isRequiredFieldBirthday: isRequiredFieldBirthday)
        
        // THEN
        
        XCTAssertEqual(isRequiredFieldBirthday, userDefaults.bool(forKey: keys.isRequiredFieldBirthdayKey))
        XCTAssertEqual(isOnlyCyrillic, userDefaults.bool(forKey: keys.isOnlyCyrillicKey))
    }
}
