//
//  MapKitService.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import Foundation
import Combine
import MapKit

final class MapKitService {
    let searchPublisher = PassthroughSubject<[MKMapItem], Never>()
    private let center: CLLocationCoordinate2D
    private let radius: CLLocationDistance = 100_000
    
    init(center: CLLocationCoordinate2D) {
        self.center = center
    }
    
    func searchAddress(keyword: String) {
        request(searchText: keyword)
    }
    
    func request(resultType: MKLocalSearch.ResultType = .pointOfInterest, searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        request.region = MKCoordinateRegion(center: self.center,
                                            latitudinalMeters: self.radius,
                                            longitudinalMeters: self.radius)
        
        let searchQuery = MKLocalSearch(request: request)
        searchQuery.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.searchPublisher.send(response.mapItems)
        }
    }
}
