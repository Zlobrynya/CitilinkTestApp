//
//  TaskNetworkClientTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import XCTest
import Foundation
@testable import CitilinkTestApp

class TaskNetworkClientTest: XCTestCase {
    // MARK: - SUT
    
    var sut: TaskNetworkClient!
    
    // MARK: - Dependencies
    
    private let mockNetworkClientFactory = MockNetworkClientFactory()
    private var mockResultHandler: MockTaskNetworkClientResultHandler!
    
    private let jsonDecoder = JSONDecoder()
    private let constant: InputDataConstantsProtocol = InputDataConstants()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        mockResultHandler = MockTaskNetworkClientResultHandler()
        sut = TaskNetworkClient(constants: constant, networkClientFactory: mockNetworkClientFactory, jsonDecoder: jsonDecoder)
        sut.resultHandler = mockResultHandler
        super.setUp()
    }
    
    override func tearDown() {
        mockResultHandler = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Functions
    
    func test_fetchTask_withDebtorInforamtion_requestCreatedWithCorrectValuesAndSendWasCalled() throws {
        // GIVEN
        
        let firstName = "testName"
        let lastName = "lastName"
        let secondaryName = "secondaryName"
        let birthday = "birthday"
        
        // WHEN
        
        sut.fetchTask(forFirstName: firstName, withLastName: lastName, andSecondaryName: secondaryName, andBirthday: birthday)
        
        // THEN
        
        XCTAssertEqual(mockNetworkClientFactory.url, constant.physical)
        XCTAssertTrue(mockNetworkClientFactory.resultHandler === sut)
        XCTAssertTrue(mockNetworkClientFactory.request!.didCallSend)
    }
    
    func test_fetchTask_factoryThrowsError_requestDidFailCalledOnResultHandler() {
        // GIVEN

        mockNetworkClientFactory.shouldThrowError = true
        let firstName = "testName"
        let lastName = "lastName"
        let secondaryName = "secondaryName"
        let birthday = "birthday"
        
        // WHEN

        sut.fetchTask(forFirstName: firstName, withLastName: lastName, andSecondaryName: secondaryName, andBirthday: birthday)

        // THEN

        XCTAssertTrue(mockResultHandler.didCallTaskRequestDidFailed)
    }
    
    func test_requestDidSucceedWithResult_decodableResult_requestDidSucceedCalledOnResultHandler() throws {
        // GIVEN
        
        let jsonObject = try JsonObject<TaskMainResponse>(
            fileName: "MockGet",
            decoder: jsonDecoder,
            bundle: Bundle(for: type(of: self))
        )
        
        let data = jsonObject.data
        let networkResult = NetworkResult(data: data, metadata: nil)
        
        // WHEN
        
        sut.requestDidSucceed(with: networkResult)
        
        // THEN
        
        XCTAssertFalse(mockResultHandler.didCallTaskRequestDidFailed)
        XCTAssertEqual(mockResultHandler.task, jsonObject.decodedItem.response.task)
    }
    
    func test_requestDidSucceedWithResult_nonDecodableResult_requestDidSucceedCalledOnResultHandler() throws {
        // GIVEN
        
        let networkResult = NetworkResult(data: Data(), metadata: nil)
        
        // WHEN
        
        sut.requestDidSucceed(with: networkResult)
        
        // THEN
        
        XCTAssertTrue(mockResultHandler.didCallTaskRequestDidFailed)
    }
    
    func test_requestDidFailWithError_userRequestDidFailCalledOnResultHandler() throws {
        
        // WHEN

        sut.requestDidFail(with: NetworkError.emptyResponse)

        // THEN

        XCTAssertTrue(mockResultHandler.didCallTaskRequestDidFailed)
    }
    
}
