//
//  MapView.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    var isVisualOnly: Bool
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isZoomEnabled = !isVisualOnly
        mapView.isScrollEnabled = !isVisualOnly
        
        let jakartaCoordinate = CLLocationCoordinate2D(latitude: -6.175784, longitude: 106.827136)
        mapView.setCenter(jakartaCoordinate, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(self)
    }
}

final class MapCoordinator: NSObject, MKMapViewDelegate {
    var mapView: MapView
    
    init(_ parent: MapView) {
        self.mapView = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.centerCoordinate)
    }
}
