//
//  UserDetailViewModelTests.swift
//  GithubUsersTests
//
//  Created by Thinh Le on 11/08/2021.
//

import XCTest
import OHHTTPStubs
import RxSwift
import RxCocoa
@testable import Calendar

class CalendarViewModelTests: XCTestCase {
    func testSuccess() {
 
        let descriptor = stub(condition: isHost("httpbin.org")) { _ in
            return HTTPStubsResponse(data: Data(), statusCode: 200, headers: nil).responseTime(0.5)
        }

        let viewModel = HomeViewModel(currentDate: Date())
        
        viewModel.getWorkouts()
        

        let expectation = self.expectation(description: "testSuccess")

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600)) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
        

        XCTAssertNotNil(viewModel.listDatesOfWeek.value)
        XCTAssertTrue(viewModel.listDatesOfWeek.value.count == 7)

        HTTPStubs.removeStub(descriptor)
    }
    
    func testFail() {
        
        let descriptor = stub(condition: isHost("httpbin.org")) { _ in
            return HTTPStubsResponse(error: CommonError.noInternetConnection).responseTime(0.5)
        }
        let viewModel = HomeViewModel(currentDate: Date())
     
        viewModel.getWorkouts()
        
        let expectation = self.expectation(description: "testFail")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600)) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertNotNil(viewModel.listDatesOfWeek.value)
        XCTAssertTrue(viewModel.listDatesOfWeek.value.count == 7)
        HTTPStubs.removeStub(descriptor)
    }
}
