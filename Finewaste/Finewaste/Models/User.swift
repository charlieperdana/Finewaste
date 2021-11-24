//
//  User.swift
//  Finewaste
//
//  Created by Andrean Lay on 05/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var profilePhotoUrl: String?
    var name: String?
    var username: String?
    var description: String?
    var productServices: [String]?
    var createdProducts: Int?
    var donatedWaste: Int?
    var location: GeoPoint?
    var isBusiness: Bool?
    var productImages: [String]?
}
