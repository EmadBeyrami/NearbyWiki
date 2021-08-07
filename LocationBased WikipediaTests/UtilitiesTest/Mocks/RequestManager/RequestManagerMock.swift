//
//  RequestManagerMock.swift
//  LocationBased WikipediaTests
//
//  Created by Emad Bayramy on 8/6/21.
//

import Foundation

@testable import LocationBased_Wikipedia

class RequestManagerMock: RequestManagerProtocol {
    
    var session: URLSession!
    
    var timeOutInterval: Double {
        return 5
    }
    
    var baseApi: String
    
    var responseValidator: ResponseValidatorProtocol
    
    var reponseLog: URLRequestLoggableProtocol?
    
    public init(session: URLSession, validator: ResponseValidatorProtocol) {
        self.baseApi = ""
        self.session = session
        self.responseValidator = validator
    }
    
    func performRequestWith<T>(baseURL: BaseAPIs, url: String, httpMethod: HTTPMethod, completionHandler: @escaping CodableResponse<T>) where T: Codable {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            usleep(400)
            if error != nil {
                return completionHandler(.failure(RequestError.connectionError))
            } else {
                let validationResult: (Result<T, RequestError>) = self.responseValidator.validation(response: response as? HTTPURLResponse, data: data)
                return completionHandler(validationResult)
            }
        }.resume()
    }
    
}
