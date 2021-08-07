//
//  GoogleLocationManager.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/7/21.
//

import Foundation
import GoogleMaps

final class GoogleMapLocationManager: NSObject {
    
    typealias SelectedMarkerTapHandler = DataCompletion<Int>
    
    // MARK: - Properties
    private var mapView: GMSMapView!
    private var didSelectMarkerCallback: SelectedMarkerTapHandler = { _ in }
    public var MarkerIsTappable: Bool = true
    
    // MARK: - Initializer
    override init() {
        super.init()
    }
    
    convenience init(forMap mapView: GMSMapView) {
        self.init()
        self.mapView = mapView
        mapView.delegate = self
    }
    
    // MARK: public functions
    public func setCameraPosition(to location: CLLocationCoordinate2D, zoom: Float = 17) {
        let cameraPosition = GMSCameraPosition(latitude: location.latitude, longitude: location.longitude, zoom: zoom)
        mapView.animate(to: cameraPosition)
    }
    
    public func markerTapBinder(_ handler: @escaping SelectedMarkerTapHandler) {
        self.didSelectMarkerCallback = handler
    }
    
    public func applyMapStyle(resource: String = "MapStyle") {
        let mapStyler = GoogleMapStyleBuilder(mapView: mapView)
        mapStyler.applyMapStyle(resource: resource)
    }
}

// MARK: Google Map Delegates (GMSMapViewDelegate)
extension GoogleMapLocationManager: GMSMapViewDelegate {
    
    // MARK: Did Select a place marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let id = marker.iconView?.tag {
            didSelectMarkerCallback(id)
        }
        return self.MarkerIsTappable
    }
}
