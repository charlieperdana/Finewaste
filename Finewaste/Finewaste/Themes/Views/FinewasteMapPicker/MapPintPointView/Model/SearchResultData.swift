//
//  SearchResultData.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import MapKit

struct SearchResultData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? "---"
        self.subtitle = mapItem.placemark.title ?? "---"
    }
}
