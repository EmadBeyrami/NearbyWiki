//
//  MarkerCreatorBuilder.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation
import GoogleMaps

// MARK: - Map Marker
// Responsible for building and adding Markers to GoogleMap
class MapMarkerBuilder {
    
    fileprivate var mapView: GMSMapView

    init(mapView: GMSMapView) {
        self.mapView = mapView
    }
    
    // MARK: For making this function more generic we can make it a protocol. but it was time cosuming so I rather not implement it in this use case
    func createMarker(_ data: GeosearchModel, location: CLLocationCoordinate2D) {
        
        let animationMarker = MarkerAnimationView(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        marker(data, location, animationMarker)
    }
    
    fileprivate func marker(_ data: GeosearchModel, _ location: CLLocationCoordinate2D, _ iconView: UIView? = nil) {
        let marker = GMSMarker()
        var lastLocation = LocationModel()
        
        marker.iconView = iconView
        marker.appearAnimation = .none
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = self.mapView
        marker.opacity = 1
        
        lastLocation.lat = "\(data.lat ?? 0.0)"
        lastLocation.lng = "\(data.lon ?? 0.0)"
        marker.position = data.lat != nil ? CLLocationCoordinate2D(latitude: data.lat ?? 0, longitude: data.lon ?? 0) : location
        marker.iconView?.tag = data.pageid ?? 0
        marker.title = data.title
        marker.map = mapView
    }
}
