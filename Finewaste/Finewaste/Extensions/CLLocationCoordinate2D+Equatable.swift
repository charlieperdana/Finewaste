//
//  CLLocationCoordinate2D+Equatable.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    
}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return fabs(lhs.latitude - rhs.latitude) < 0.005 && fabs(lhs.longitude - rhs.longitude) < 0.005
}
