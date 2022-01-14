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
    @Binding var center: CLLocationCoordinate2D
    var visibleRegionChangeHandler: ((CLLocationCoordinate2D) -> Void)?
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isZoomEnabled = !isVisualOnly
        mapView.isScrollEnabled = !isVisualOnly
        
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: .init(500),
                                        longitudinalMeters: .init(500))
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        view.setCenter(center, animated: true)
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(self)
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            self.parent.visibleRegionChangeHandler?(mapView.centerCoordinate)
        }
    }
}
