//
//  MapPinPointViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import Foundation
import Combine
import MapKit
import CoreLocation

final class MapPinPointViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    // Default to Jakarta
    @Published var currentMapCenter =  CLLocationCoordinate2D(latitude: -6.175784, longitude: 106.827136)
    var latestMapCenter = CLLocationCoordinate2D(latitude: -6.175784, longitude: 106.827136)
    
    @Published var searchQuery = "" {
        didSet {
            searchAddress(text: searchQuery)
        }
    }
    
    @Published var searchResultData = [SearchResultData]()
    
    var service: MapKitService
    var locationManager: CLLocationManager
    
    init(coordinate: CLLocationCoordinate2D) {
        service = MapKitService(center: coordinate)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        cancellable = service.searchPublisher.sink { mapItems in
            self.searchResultData = mapItems.map({ SearchResultData(mapItem: $0) })
        }
        
        self.currentMapCenter = coordinate
    }
    
    private func searchAddress(text: String) {
        service.searchAddress(keyword: text)
    }
    
    func goToCurrentLocation() {
        let status = self.locationManager.authorizationStatus
        
        if status == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            let location = locationManager.location
            self.currentMapCenter = location?.coordinate ?? currentMapCenter
        } else if status == .denied || status == .restricted {
            print("User denied/restrict location..")
        }
    }
}
