//
//  LocationModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import CoreLocation

struct LocationModel: Codable {
    
    var lat: String?
    var lng: String?
    
    func latDouble() -> Double {
        return Double(self.lat ?? "0") ?? 0.0
    }
    
    func lngDouble() -> Double {
        return Double(self.lng ?? "0") ?? 0.0
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        .init(latitude: latDouble(), longitude: lngDouble())
    }
    
    func location() -> CLLocation {
        .init(latitude: latDouble(), longitude: lngDouble())
    }
    
}

// MARK: - Comparable

extension LocationModel: Equatable {
    
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }
    
}
