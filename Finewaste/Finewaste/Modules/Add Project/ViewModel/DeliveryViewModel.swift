//
//  DeliveryViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 16/11/21.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class DeliveryViewModel: ObservableObject {
    var projectLocation: String = ""
    var isLocationSelected: Bool = false
    @Published var pickUpCoordinate: CLLocationCoordinate2D = .init(latitude: -6.175784, longitude: 106.827136) {
        didSet {
            isLocationSelected = true
            getAddress(fromCoordinate: pickUpCoordinate) { address in
                self.projectModel.deliveryAddress = address
//                print("halo: \(address)")
            }
            self.projectModel.location = GeoPoint(latitude: pickUpCoordinate.latitude, longitude: pickUpCoordinate.longitude)
        }
    }
    
    @Published var projectModel = NewProjectModel()
    
    init() {
        
    }
    
    private func getAddress(fromCoordinate coordinate: CLLocationCoordinate2D, completion: @escaping (String) -> Void) {
        let lat = coordinate.latitude
        let long = coordinate.longitude
        let loc = CLLocation(latitude: lat, longitude: long)
        
        loc.fetchShortLocation { placemark, error in
            if error != nil {
                self.projectLocation = "---"
            }
            
            guard let placemark = placemark else {
                return
            }
            
            completion(self.getFullLocation(placemark: placemark))
        }
    }
    
    private func getFullLocation(placemark: CLPlacemark) -> String {
        let streetName = placemark.name ?? ""
        let subLocality = placemark.subLocality ?? ""
        let locality = placemark.locality ?? ""
        let administrativeArea = placemark.administrativeArea ?? ""
        
        let location = "\(streetName), \(locality), \(subLocality), \(administrativeArea)"
        
        return location
    }
}
