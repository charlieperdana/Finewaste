//
//  ContributionMaterial.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContributionMaterial: Codable, Identifiable {
    @DocumentID var id: String?
    var contributionId: String?
    var name: String?
    var quantity: Int?
    var images: [String]?
}
