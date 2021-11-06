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
    var contributor: String?
    var post: String?
    var images: [String]?
    var deliveryType: Int?
    var location: GeoPoint?
}
