//
//  CoreLocation+LongAndLat.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import CoreLocation

extension CLLocation {
    
    func getLatitude() -> Double {
        self.coordinate.latitude
    }
    
    func getLongitude() -> Double {
        self.coordinate.longitude
    }
    
    // MARK: - According to API Doc We should send Coordinates seperated with a '|'.
    /// e.g: Latitude '|' Longitude
    func getFormatedCoordination() -> String {
        let lat = String(getLatitude())
        let lon = String(getLongitude())
        return lat + "|" + lon
    }
}
