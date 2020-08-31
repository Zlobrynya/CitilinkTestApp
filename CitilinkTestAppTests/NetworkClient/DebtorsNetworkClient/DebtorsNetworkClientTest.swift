//
//  DebtorsNetworkClientTest.swift
//  CitilinkTestAppTests
//
//  Created by Nikitin Nikita on 29.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import XCTest
import Foundation
@testable import CitilinkTestApp

class DebtorsNetworkClientTest: XCTestCase {
    // MARK: - SUT
    
    var sut: DebtorsNetworkClient!
    
    // MARK: - Dependencies
    
    private let mockNetworkClientFactory = MockNetworkClientFactory()
    private var mockResultHandler: MockDebtorsNetworkClientResultHandler!
    
    private let jsonDecoder = JSONDecoder()
    private let constant: InputDataConstantsProtocol = InputDataConstants()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        mockResultHandler = MockDebtorsNetworkClientResultHandler()
        sut = DebtorsNetworkClient(constants: constant, networkClientFactory: mockNetworkClientFactory, jsonDecoder: jsonDecoder)
        sut.resultHandler = mockResultHandler
    }
    
    override func tearDown() {
        mockResultHandler = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Functions
    
    func test_fetchDebtorsForTask_withTask_requestCreatedWithCorrectValuesAndSendWasCalled() throws {
        // GIVEN
        
        let task = "task"
        
        // WHEN
        
        sut.fetchDebtorsForTask(task)
        
        // THEN
        
        XCTAssertEqual(mockNetworkClientFactory.url, constant.result)
        XCTAssertTrue(mockNetworkClientFactory.resultHandler === sut)
        XCTAssertTrue(mockNetworkClientFactory.request!.didCallSend)
    }
    
    func test_fetchTask_factoryThrowsError_requestDidFailCalledOnResultHandler() {
        // GIVEN

        mockNetworkClientFactory.shouldThrowError = true
        let task = "task"

        // WHEN

        sut.fetchDebtorsForTask(task)

        // THEN

        XCTAssertTrue(mockResultHandler.didCallDebtorsRequestDidFailed)
    }
    
    func test_requestDidSucceedWithResult_decodableResult_requestDidSucceedCalledOnResultHandler() throws {
        // GIVEN
        
        let jsonObject = try JsonObject<MainResponse>(
            fileName: "MockDebtors",
            decoder: jsonDecoder,
            bundle: Bundle(for: type(of: self))
        )
        
        let data = jsonObject.data
        let networkResult = NetworkResult(data: data, metadata: nil)
        
        // WHEN
        
        sut.requestDidSucceed(with: networkResult)
        
        // THEN
        
        let mockDebtors = jsonObject.decodedItem.response.result.first!.result
        
        XCTAssertFalse(mockResultHandler.didCallDebtorsRequestDidFailed)
        for (i, debtor) in mockResultHandler.debtors.enumerated() {
            XCTAssertEqual(mockDebtors[i].details, debtor.details)
        }
    }
    
    func test_requestDidSucceedWithResult_nonDecodableResult_requestDidSucceedCalledOnResultHandler() throws {
        // GIVEN
        
        let networkResult = NetworkResult(data: Data(), metadata: nil)
        
        // WHEN
        
        sut.requestDidSucceed(with: networkResult)
        
        // THEN
        
        XCTAssertTrue(mockResultHandler.didCallDebtorsRequestDidFailed)
    }
    
    func test_requestDidFailWithError_userRequestDidFailCalledOnResultHandler() throws {
        
        // WHEN

        sut.requestDidFail(with: NetworkError.emptyResponse)

        // THEN

        XCTAssertTrue(mockResultHandler.didCallDebtorsRequestDidFailed)
    }
    
}
