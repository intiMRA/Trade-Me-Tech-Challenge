//
//  ListingsViewModelTests.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 25/01/22.
//

import XCTest
import Combine

class ListingsViewModelTests: XCTestCase {
    var cancellable = Set<AnyCancellable>()

    func testFetchingListings() {
        let api = MockListRequestableApi()
        let vm = ListingsViewModel(netwokLayer: api)
        vm.populateList()
        let expectation = self.expectation(description: "wait for list")
        vm.$list
            .dropFirst()
            .sink { list in
                expectation.fulfill()
                XCTAssertEqual("test title", list[0].title)
            }
            .store(in: &cancellable)
        waitForExpectations(timeout: 10)
    }
    
    func testFailFetchingListings() {
        let api = MockListRequestableApi()
        api.shouldFail = true
        let vm = ListingsViewModel(netwokLayer: api)
        vm.populateList()
        let expectation = self.expectation(description: "wait for list")
        vm.$showAlert
            .dropFirst()
            .sink { value in
                expectation.fulfill()
                XCTAssertTrue(value)
                XCTAssertEqual(vm.alertContent.title, "Error")
                XCTAssertEqual(vm.alertContent.message, "No response")
            }
            .store(in: &cancellable)
        waitForExpectations(timeout: 10)
    }

}
