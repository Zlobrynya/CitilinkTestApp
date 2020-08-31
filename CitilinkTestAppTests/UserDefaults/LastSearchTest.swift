//
//  LastSearchTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import XCTest
import Foundation
@testable import CitilinkTestApp

class LastSearchTest: XCTestCase {
    // MARK: - SUT
    
    var sut: LastSearch!
    
    // MARK: - Dependencies
    
    private var userDefaults: UserDefaults!
    private let keys: LastSearchKeysProtocol = LastSearchKeys()
    
    // MARK: Constants
    
    private let testConst = "TestTest"
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults.standard
        sut = LastSearch(userDefaults: userDefaults, keys: keys)
    }
    
    override func tearDown() {
        sut = nil
        userDefaults = nil
        super.tearDown()
    }
    
    // MARK: - Test Functions

    func test_lastName_userDefaultsHasLastName_lastNameReceivedCorrectly() {
        // GIVEN
        
        userDefaults.set(testConst, forKey: keys.lastNameKey)
        
        // WHEN
        
        let lastName = sut.lastName
        
        // THEN
        
        XCTAssertEqual(lastName, testConst)
        userDefaults.set(nil, forKey: keys.lastNameKey)
    }
    
    func test_lastName_userDefaultsHasNotLastName_lastNameIsEmpty() {
        // GIVEN

        userDefaults.set(nil, forKey: keys.lastNameKey)
        
        // WHEN
        
        let lastName = sut.lastName
        
        // THEN
        
        XCTAssertTrue(lastName.isEmpty)
    }
    
    func test_firstName_userDefaultsHasFirstName_firstNameReceivedCorrectly() {
        // GIVEN
        
        userDefaults.set(testConst, forKey: keys.firstNameKey)
        
        // WHEN
        
        let firstName = sut.firstName
        
        // THEN
        
        XCTAssertEqual(firstName, testConst)
    }
    
    func test_firstName_userDefaultsHasNotFirstName_firstNameIsEmpty() {
        // GIVEN

        userDefaults.set(nil, forKey: keys.firstNameKey)
        
        // WHEN
        
        let firstName = sut.firstName
        
        // THEN
        
        XCTAssertTrue(firstName.isEmpty)
    }
    
    func test_secondName_userDefaultsHasSecondName_secondNameReceivedCorrectly() {
        // GIVEN
        
        userDefaults.set(testConst, forKey: keys.secondNameKey)
        
        // WHEN
        
        let secondName = sut.secondName
        
        // THEN
        
        XCTAssertEqual(secondName, testConst)
    }
    
    func test_secondName_userDefaultsHasNotSecondName_secondNameIsEmpty() {
        // GIVEN

        userDefaults.set(nil, forKey: keys.secondNameKey)
        
        // WHEN
        
        let secondName = sut.secondName
                    
        // THEN
        
        XCTAssertTrue(secondName.isEmpty)
    }
    
    func test_birthday_userDefaultsHasBirthday_birthdayReceivedCorrectly() {
        // GIVEN
        
        userDefaults.set(testConst, forKey: keys.birthdayKey)
        
        // WHEN
        
        let birthday = sut.birthday
        
        // THEN
        
        XCTAssertEqual(birthday, testConst)
        userDefaults.set(nil, forKey: keys.birthdayKey)
    }
   
    func test_birthday_userDefaultsHasNotBirthday_birthdayIsEmpty() {
        // WHEN
        
        let birthday = sut.birthday
        
        // THEN
        
        XCTAssertTrue(birthday.isEmpty)
    }
    
    func test_update_dataForSave_dataReceivedCorrectly() {
        // GIVEN

        let firstName = "TestF"
        let lastName = "TestL"
        let secondName = "TestS"
        let birthday = "TestB"
        
        // WHEN
        
        sut.update(lastName: lastName, firstName: firstName, secondName: secondName, birthday: birthday)
        
        // THEN
        
        XCTAssertEqual(firstName, userDefaults.string(forKey: keys.firstNameKey))
        XCTAssertEqual(lastName, userDefaults.string(forKey: keys.lastNameKey))
        XCTAssertEqual(secondName, userDefaults.string(forKey: keys.secondNameKey))
        XCTAssertEqual(birthday, userDefaults.string(forKey: keys.birthdayKey))
    }
    
}
