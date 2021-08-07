//
//  MainViewModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation
import CoreLocation

final class MainViewModel {
    // MARK: - requesModels
    private var googleRequestModel: DirectionsRequestModel = DirectionsRequestModel()
    private var wikiRequestModel: NearbyArticlesRequestModel = NearbyArticlesRequestModel()
    
    // MARK: - Services Initialize and injection
    var placesService: PlacesServiceProtocol
    
    init(placesService: PlacesServiceProtocol) {
        self.placesService = placesService
    }
    
    // MARK: - Properties & Publishers
    var currentLocation: CLLocation! = nil
    var loading: DataCompletion<Bool>?
    var places: DataCompletion<[GeosearchModel]>?
    var errorHandler: DataCompletion<String>?
    private var allPlaces: [GeosearchModel] = []
    private var selectedDestinationCoordinate: CLLocationCoordinate2D?
    
    // MARK: - API Requests
    func getNearbyArticles() {
        self.loading?(true)
        
        placesService.getNearbyPlaces(params: nearbyPlacesQueryBuilder()) { [weak self] result in
            guard let self = self else { return }
            self.loading?(false)
            switch result {
            case .success(let articleResult):
                if let articles = articleResult.query?.geosearch {
                    self.allPlaces.append(contentsOf: articles)
                    self.places?(articles)
                }
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
    
    private func getDirections(from originCoordinates: CLLocationCoordinate2D, to destinationCoordinates: CLLocationCoordinate2D) {
        
        let newRequestModel = googleRequestModel
        newRequestModel.setOriginCoordinate(originCoordinates)
        newRequestModel.setDestinationCoordinate(destinationCoordinates)
        
        placesService.googleMapGetDirections(params: newRequestModel) { [weak self] result in
            guard let self = self else { return }
            self.loading?(false)
            switch result {
            case .success(let routes):
                print(routes)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Query Builder
    // we can customize data and create a builder class but its time consuming
    private func nearbyPlacesQueryBuilder() -> NearbyArticlesRequestModel {
        var newRequestModel = wikiRequestModel
        newRequestModel.list = "geosearch"
        newRequestModel.action = "query"
        newRequestModel.gsradius = 10000
        newRequestModel.gscoord = currentLocation.getFormatedCoordination()
        newRequestModel.gslimit = 50
        newRequestModel.format = "json"
        return newRequestModel
    }
    
    // MARK: - validators
    private func isValidDataForPageDetail(pageId: String) -> Bool {
        
        guard let intId = Int(pageId) else {
            self.loading?(false)
            errorHandler?(LocalizedStrings.pageIdNotValid.value)
            return false
        }
        
        guard let destination = findPlaceLocation(id: intId) else {
            self.loading?(false)
            errorHandler?(LocalizedStrings.pageIdNotValid.value)
            return false
        }
        
        selectedDestinationCoordinate = destination
        
        return true
    }
    
    func findCoordinateFromPageIdAndGetDirections(pageId: String) {
        self.loading?(true)
        
        if !isValidDataForPageDetail(pageId: pageId) { return }
        let originCoordinate = currentLocation2DcCoordinate()
        let destionationCoordinate = selectedDestinationCoordinate!
        
        getDirections(from: originCoordinate, to: destionationCoordinate)
    }
    
    // MARK: - Helpers
    private func currentLocation2DcCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: currentLocation.getLatitude(), longitude: currentLocation.getLongitude())
    }
    
    @discardableResult
    private func findPlaceLocation(id: Int) -> CLLocationCoordinate2D? {
        guard let place = allPlaces.first(where: { $0.pageid == id }),
              let destinationLat = place.lat,
              let destinationLong = place.lon else {
            self.loading?(false)
            errorHandler?(LocalizedStrings.couldntFindDest.value)
            return nil
        }
        return CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLong)
    }
    
}
