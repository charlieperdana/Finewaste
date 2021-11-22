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
    var contributorId: String?
    var projectId: String?
    var projectOwnerId: String?
    var projectName: String?
    var deliveryType: String?
    var location: GeoPoint?
    @ServerTimestamp var createdDate: Timestamp?
    var confirmedDate: Timestamp?
    var deliveryDate: Timestamp?
    var rejectionReason: String?
    var archived: Bool?
}
