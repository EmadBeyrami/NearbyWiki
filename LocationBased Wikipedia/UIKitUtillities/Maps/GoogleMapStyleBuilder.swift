//
//  GoogleMapStyleBuilder.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/6/21.
//

import Foundation
import GoogleMaps

// MARK: - Google Map Style
// Responsible for adding style to your Google map view
/// You `MUST` add style json and then pass the `JSONFileName` to `applyStyle` function
class GoogleMapStyleBuilder {
    
    private var mapView: GMSMapView!
    
    init(mapView: GMSMapView) {
        self.mapView = mapView
    }
    
    func applyMapStyle(resource: String = "MapStyle") {
        // map view style
        do {
            if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
}
