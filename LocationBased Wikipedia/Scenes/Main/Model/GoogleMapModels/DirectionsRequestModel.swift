//
//  DirectionsRequestModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation
import CoreLocation

class DirectionsRequestModel: CodablePro {
    private(set) var origin: String?
    private(set) var destination: String?
    private(set) var key: String? = DataManager.shared.googleMapAccessToken
}

extension DirectionsRequestModel {
    func setOriginCoordinate(_ coordinates: CLLocationCoordinate2D) {
        let lat = coordinates.latitude
        let lon = coordinates.longitude
        origin = "\(lat),\(lon)"
    }
    
    func setDestinationCoordinate(_ coordinates: CLLocationCoordinate2D) {
        let lat = coordinates.latitude
        let lon = coordinates.longitude
        destination = "\(lat),\(lon)"
    }
}
