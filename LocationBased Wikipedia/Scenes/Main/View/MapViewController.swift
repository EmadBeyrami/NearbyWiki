//
//  ViewController.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import UIKit
import GoogleMaps

class MapViewController: BaseVC, Storyboarded {
    
    // MARK: - IBOutlets
    // Not using WEAK IBOultet because: https://stackoverflow.com/a/31395938
    @IBOutlet var mapView: GMSMapView!
    
    // MARK: - Properties
    fileprivate let locationManager = LocationManager(withAccuracy: .best)
    fileprivate lazy var googleLocationManager: GoogleMapLocationManager = { GoogleMapLocationManager(forMap: mapView) }()
    
    // MARK: Coordinator
    weak var coordinator: AppCoordinator?
    
    // MARK: ViewModel
    private let mainViewModel = MainViewModel(placesService: PlacesService.shared)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - View Setup
    private func setupView() {
        title = LocalizedStrings.nearbyArticles.value
        setupBindings()
        setupResponseBindings()
        setuptMapView()
    }
    
    // MARK: - MAP Related
    fileprivate func setuptMapView() {
        
        // map style
        googleLocationManager.applyMapStyle()
        
        // Map View setup
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.indoorPicker = false
        mapView.isBuildingsEnabled = false
        mapView.isIndoorEnabled = false
    }
    
    fileprivate func setCurrentLocation() {
        guard let location = mainViewModel.currentLocation else {
            self.showAlert(message: LocalizedStrings.locationError.value)
            return
        }
        let currentCoordinate = CLLocationCoordinate2D(latitude: location.getLatitude(), longitude: location.getLongitude())
        googleLocationManager.setCameraPosition(to: currentCoordinate)
        getData()
    }
    
    // MARK: - Bindings
    fileprivate func setupBindings() {
        // Map and Location Manager Bindings
        locationManager.getCurrentLocation { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .failure(let locationError):
                switch locationError {
                case .authorizationFailed(let description):
                    self.showAlert(message: description)
                case .locationUpdationFailed(let description):
                    self.showAlert(message: description)
                }
            case .success(let location):
                print("location is :", location)
                self.locationManager.stopUpdatinglocation()
                if self.mainViewModel.currentLocation == nil {
                    self.mainViewModel.currentLocation = location
                }
                self.setCurrentLocation()
            }
        }
        
        googleLocationManager.markerTapBinder { [weak self] id in
            guard let self = self else { return }
            let stringId = "\(id)"
            self.coordinateToDetail(pageID: stringId)
        }
    }
    
    fileprivate func setupResponseBindings() {
        
        // Subscribe to Loading
        mainViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.view.animateActivityIndicator() : self.view.removeActivityIndicator()
        }
        
        // Subscribe to Places
        mainViewModel.places = { [weak self] places in
            guard let self = self else { return }
            // Show and set markers
            let markerBuilder = MapMarkerBuilder(mapView: self.mapView)
            places.forEach { place in
                let coordinate = CLLocationCoordinate2D(latitude: place.lat ?? 0, longitude: place.lon ?? 0)
                markerBuilder.createMarker(place, location: coordinate)
            }
        }
        
        // Subscribe to errors
        mainViewModel.errorHandler = { [weak self] error in
            guard let self = self else { return }
            self.showAlert(message: error)
        }
        
    }
    
    // MARK: - coordinator calls
    fileprivate func coordinateToDetail(pageID: String) {
        coordinator?.toDetailModal(id: pageID, getThereCompletion: { [weak self] (pageId) in
            guard let self = self else { return }
            // call viewmodel to get directions
            self.mainViewModel.findCoordinateFromPageIdAndGetDirections(pageId: pageId)
        })
    }
    
    // MARK: - Network Calls
    fileprivate func getData() {
        self.mainViewModel.getNearbyArticles()
    }
    
}
