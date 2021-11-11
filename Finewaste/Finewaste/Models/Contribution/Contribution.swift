//
//  Contribution.swift
//  Finewaste
//
//  Created by Andrean Lay on 05/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Contribution: Codable, Identifiable {
    @DocumentID var id: String?
    var status: Int? = 0
    var contributor: String?
    var projectId: String?
    var deliveryType: String??
    var location: GeoPoint?
}
