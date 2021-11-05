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
    var deadline: Int?
    var neededMaterials: [ProjectMaterial]?
    var images: [String]?
    var deliveryType: [String]?
    var location: GeoPoint?
    var updates: [ProjectUpdate]?
}

struct ProjectMaterial: Codable, Identifiable {
    @DocumentID var id: String?
    var materialName: String?
    var target: Int?
    var strictLimitation: Bool?
    var prerequisite: [String]?
}

struct ProjectUpdate: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdDate: Timestamp?
    var description: String?
    var images: [String]?
}
