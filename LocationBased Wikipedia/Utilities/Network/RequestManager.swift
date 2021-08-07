//
//  RequestManager.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation

/*
 This is app network layer that I wrote for my apps, it is super light and no need for adding alamofire to app :)
 
 */

typealias Parameters = [String: Any]
typealias CodableResponse<T: Codable> = (Result<T, RequestError>) -> Void

final class RequestManager: NSObject, URLSessionDelegate {
    
    // https://en.wikipedia.org/w/api.php?action=query&list=geosearch&gsradius=10000&gscoord=60.1831906%7C24.9285439&gslimit=50&format=json
    var baseApi: String = BaseAPIs.wikipedia.url// "https://en.wikipedia.org/w/api.php"
    
    var session: URLSession!
    
    var responseValidator: ResponseValidatorProtocol
    
    var reponseLog: URLRequestLoggableProtocol?
    
    typealias Headers = [String: String]

    private override init() {
        self.reponseLog = ResponseLog()
        self.responseValidator = ResponseValidator()
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    public init(session: URLSession, validator: ResponseValidatorProtocol) {
        self.session = session
        self.responseValidator = validator
    }
    
    static let shared = RequestManager()
    
}

extension RequestManager: RequestManagerProtocol {
    
    var timeOutInterval: Double {
        return 40
    }
    
    func performRequestWith<T: Codable>(baseURL: BaseAPIs = .wikipedia, url: String, httpMethod: HTTPMethod, completionHandler: @escaping CodableResponse<T>) {
        
        self.baseApi = baseURL.url
        
        let headers = headerBuilder()
        
        let urlRequest = urlRequestBuilder(url: url, header: headers, httpMethod: httpMethod)
        
        performURLRequest(urlRequest, completionHandler: completionHandler)
    }
    
    private func headerBuilder() -> Headers {
        let headers = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    private func urlRequestBuilder(url: String, header: Headers, httpMethod: HTTPMethod) -> URLRequest {
        
        var urlRequest = URLRequest(url: URL(string: baseApi + url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeOutInterval)
        urlRequest.allHTTPHeaderFields = header
        
        urlRequest.httpMethod = httpMethod.rawStringValue
        
        return urlRequest
    }
    
    private func performURLRequest<T: Codable>(_ request: URLRequest, completionHandler: @escaping CodableResponse<T>) {
        
        session.dataTask(with: request) { (data, response, error) in
            self.reponseLog?.logResponse(response as? HTTPURLResponse, data: data, error: error, HTTPMethod: request.httpMethod)
            if error != nil {
                return completionHandler(.failure(RequestError.connectionError))
            } else {
                let validationResult: (Result<T, RequestError>) = self.responseValidator.validation(response: response as? HTTPURLResponse, data: data)
                return completionHandler(validationResult)
            }
        }.resume()
    }
}
