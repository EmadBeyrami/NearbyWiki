//
//  WikipediaMapService.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation
/*

 This is Wikipedia and Google Service, responsible for making api calls of getting Articles and places and directions.
 we could seperate the map and wikipedia services
 
 */

typealias PlacesCompletionHandler = (Result<BaseResponse<QueryModel>, RequestError>) -> Void
typealias DetailsCompletionHandler = (Result<BaseResponse<PlaceDetailResponseModel>, RequestError>) -> Void
typealias GoogleDirectionCompletionHandler = (Result<DirectionBaseModel, RequestError>) -> Void

protocol PlacesServiceProtocol {
    func getNearbyPlaces(params: NearbyArticlesRequestModel, completionHandler: @escaping PlacesCompletionHandler)
    func getDetail(params: PageDetailRequestModel, completionHandler: @escaping DetailsCompletionHandler)
    func googleMapGetDirections(params: DirectionsRequestModel, completionHandler: @escaping GoogleDirectionCompletionHandler)
}

/*
 Endpoints is URLPath of Api calls
 */

private enum EndPoints {
    case nearbyPlaces
    case detail
    case direction
    
    var path: String {
        switch self {
        case .nearbyPlaces:
            return ""
        case .detail:
            return ""
        case .direction:
            return "/maps/api/directions/json"
        }
    }
}

class PlacesService: PlacesServiceProtocol {
    
    private let requestManager: RequestManagerProtocol
    
    public static let shared: PlacesServiceProtocol = PlacesService(requestManager: RequestManager.shared)
    
    // We can also inject requestManager for testing purposes.
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    func getNearbyPlaces(params: NearbyArticlesRequestModel, completionHandler: @escaping PlacesCompletionHandler) {
        
        guard let queryParam = params.toQueryString() else {
            completionHandler(.failure(.queryParameterError))
            return
        }
        
        let url = EndPoints.nearbyPlaces.path + queryParam
        self.requestManager.performRequestWith(baseURL: .wikipedia, url: url, httpMethod: .get) { (result: Result<BaseResponse<QueryModel>, RequestError>) in
            // Taking Data to main thread so we can update UI.
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
    
    func getDetail(params: PageDetailRequestModel, completionHandler: @escaping DetailsCompletionHandler) {
        
        guard let queryParam = params.toQueryString() else {
            completionHandler(.failure(.queryParameterError))
            return
        }
        let url = EndPoints.nearbyPlaces.path + queryParam
        
        self.requestManager.performRequestWith(baseURL: .wikipedia, url: url, httpMethod: .get) { (result: Result<BaseResponse<PlaceDetailResponseModel>, RequestError>) in
            // Taking Data to main thread so we can update UI.
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
    }
    
    func googleMapGetDirections(params: DirectionsRequestModel, completionHandler: @escaping GoogleDirectionCompletionHandler) {
        
        guard let queryParam = params.toQueryString() else {
            completionHandler(.failure(.queryParameterError))
            return
        }
        let url = EndPoints.direction.path + queryParam
        
        self.requestManager.performRequestWith(baseURL: .googleMaps, url: url, httpMethod: .get) { (result: Result<DirectionBaseModel, RequestError>) in
            // Taking Data to main thread so we can update UI.
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
