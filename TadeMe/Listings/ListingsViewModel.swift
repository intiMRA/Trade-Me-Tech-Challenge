//
//  ListingsViewModel.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 21/01/22.
//

import Foundation
import Combine
import SwiftUI

struct Item: Identifiable {
    let id: UUID
    let info: String
}

class ListingsViewModel: ObservableObject {
    private let customerKey = ""
    private let customerSec = ""
    
    @Published var list: [ListResponse.ListItem] = []
    @Published var showAlert = false
    private var cancellable = Set<AnyCancellable>()
    private let netwokLayer: Requestable
    var alertContent = (title: "", message: "")
    
    init(netwokLayer: Requestable = DefaultNetworkRequestable(keyDecodingStrategy: .convertFromSnakeCase)) {
        self.netwokLayer = netwokLayer
    }
    
    func populateList() {
        fetchData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case .badURL(let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .apiError(code: _, error: let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .invalidJSON(let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .unauthorized(code: _, error: let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .badRequest(code: _, error: let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .serverError(code: _, error: let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .noResponse(let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .unableToParseData(let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    case .unknown(code: _, error: let error):
                        self.alertContent = (title: "Error".localized, message: error.description)
                    }
                    self.showAlert = true
                }
            } receiveValue: { response in
                let numberToDrop = (response.list?.count ?? 0) - 20
           
                self.list = response.list?.dropLast(max(numberToDrop, 0)) ?? []
                
            }
            .store(in: &cancellable)

    }
    
    private func fetchData() -> AnyPublisher<ListResponse, NetworkError> {
        let authString = "OAuth oauth_consumer_key=\"\(customerKey)\",oauth_signature_method=\"PLAINTEXT\",oauth_signature=\"\(customerSec)&\""
        let requestData = [
            "Authorization": authString,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let request = NetworkRequest(
            url: "https://api.tmsandbox.co.nz/v1/listings/latest.json",
            headers: requestData,
            httpMethod: .GET)
        return netwokLayer.request(request)
    }
}
