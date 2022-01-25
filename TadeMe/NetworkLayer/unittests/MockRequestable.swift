//
//  MockRequestable.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 25/01/22.
//

import Foundation
import Combine

class MockListRequestableApi: Requestable {
    var requestTimeOut: Float = 0.0
    var shouldFail: Bool = false
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    
    func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        if shouldFail {
            return Fail(error: NetworkError.noResponse("No response"))
                .eraseToAnyPublisher()
        } else {
            let list = [
                ListResponse.ListItem(title: "test title",
                                      region: "Wellington",
                                      pictureHref: "none",
                                      priceDisplay: "$13",
                                      buyNowPrice: 40,
                                      isClassified: true,
                                      isReserveMet: true,
                                      id: 1)
            ]
            return Just(ListResponse(list: list) as! T)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
    }
    
    
}
