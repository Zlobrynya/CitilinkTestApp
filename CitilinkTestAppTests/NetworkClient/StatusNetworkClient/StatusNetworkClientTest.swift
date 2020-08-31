//
//  StatusNetworkClientTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import XCTest
import Foundation
@testable import CitilinkTestApp

class StatusNetworkClientTest: XCTestCase {
    // MARK: - SUT
    
    var sut: StatusNetworkClient!
    
    // MARK: - Dependencies
    
    private let mockNetworkClientFactory = MockNetworkClientFactory()
    private var mockResultHandler: MockStatusNetworkClientResultHandler!
    
    private let jsonDecoder = JSONDecoder()
    private let constant: InputDataConstantsProtocol = InputDataConstants()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        mockResultHandler = MockStatusNetworkClientResultHandler()
        sut = StatusNetworkClient(constants: constant, networkClientFactory: mockNetworkClientFactory, jsonDecoder: jsonDecoder)
        sut.resultHandler = mockResultHandler
    }
    
    override func tearDown() {
        mockResultHandler = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Functions
    
    func test_fetchStatusForTask_withTask_requestCreatedWithCorrectValuesAndSendWasCalled() throws {
        // GIVEN
        
        let task = "task"
        
        // WHEN
        
        sut.fetchStatusForTask(task)
        
        // THEN
        
        XCTAssertEqual(mockNetworkClientFactory.url, constant.status)
        XCTAssertTrue(mockNetworkClientFactory.resultHandler === sut)
        XCTAssertTrue(mockNetworkClientFactory.request!.didCallSend)
    }
    
    func test_fetchStatusForTask_factoryThrowsError_requestDidFailCalledOnResultHandler() {
        // GIVEN

        mockNetworkClientFactory.shouldThrowError = true
        let task = "task"

        // WHEN

        sut.fetchStatusForTask(task)

        // THEN

        XCTAssertTrue(mockResultHandler.didCallStatusRequestDidFailed)
    }
    
    func test_requestDidSucceedWithResult_decodableResult_requestDidSucceedCalledOnResultHandler() throws {
        // GIVEN
        
        let data = try JsonObject<StatusMainResponse>(
            fileName: "MockStatus",
            decoder: jsonDecoder,
            bundle: Bundle(for: type(of: self))
        ).data
        let networkResult = NetworkResult(data: data, metadata: nil)
        let task = "tasl"
        
        sut.fetchStatusForTask(task)
        
        // WHEN
        
        sut.requestDidSucceed(with: networkResult)
        
        // THEN
                
        XCTAssertFalse(mockResultHandler.didCallStatusRequestDidFailed)
        XCTAssertEqual(mockResultHandler.status, TaskStatus.complete)
        XCTAssertEqual(mockResultHandler.task, task)
    }
    
    func test_requestDidSucceedWithResult_nonDecodableResult_requestDidSucceedCalledOnResultHandler() throws {
        // GIVEN
        
        let networkResult = NetworkResult(data: Data(), metadata: nil)
        
        // WHEN
        
        sut.requestDidSucceed(with: networkResult)
        
        // THEN
        
        XCTAssertTrue(mockResultHandler.didCallStatusRequestDidFailed)
    }
    
    func test_requestDidFailWithError_userRequestDidFailCalledOnResultHandler() throws {
        
        // WHEN

        sut.requestDidFail(with: NetworkError.emptyResponse)

        // THEN

        XCTAssertTrue(mockResultHandler.didCallStatusRequestDidFailed)
    }
    
}
