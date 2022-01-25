//
//  NetworkTests.swift
//  TadeMeTests
//
//  Created by Inti Albuquerque on 25/01/22.
//

import XCTest
import Combine

class NetworkTests: XCTestCase {
    var cancellable = Set<AnyCancellable>()
    func testUrlError() {
        let layer = DefaultNetworkRequestable()
        let request = NetworkRequest(url: "", httpMethod: .GET)
        let res: AnyPublisher<ListResponse, NetworkError> = layer.request(request)
        let expectation = self.expectation(description: "waiting for error")
        
        res
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    expectation.fulfill()
                    switch error {
                    case .badURL(_):
                        break
                    default:
                        XCTFail("not the correct error")
                    }
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellable)
        
        waitForExpectations(timeout: 10)
    }
    
    func testInavalidJsonError() {
        let layer = DefaultNetworkRequestable()
        let request = NetworkRequest(url: "https://www.google.com", httpMethod: .GET)
        let res: AnyPublisher<ListResponse, NetworkError> = layer.request(request)
        let expectation = self.expectation(description: "waiting for error")
        
        res
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    expectation.fulfill()
                    switch error {
                    case .invalidJSON(_):
                        break
                    default:
                        XCTFail("not the correct error")
                    }
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellable)
        
        waitForExpectations(timeout: 10)
    }

}
