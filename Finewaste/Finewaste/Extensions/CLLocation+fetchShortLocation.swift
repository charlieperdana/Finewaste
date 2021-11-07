//
//  CLLocation+fetchShortLocation.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import CoreLocation

extension CLLocation {
    func fetchShortLocation(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self) { placemark, error in
            completion(placemark?.first, error)
        }
    }
}
