//
//  Project.swift
//  Finewaste
//
//  Created by Andrean Lay on 01/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Project: Codable, Identifiable {
    @DocumentID var id: String?
    var poster: String?
    var projectName: String?
    var description: String?
    var deadline: Timestamp?
    var images: [String]?
    var deliveryType: [String]?
    var location: GeoPoint?
}
