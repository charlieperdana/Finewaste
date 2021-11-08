//
//  ProjectMaterial.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProjectMaterial: Codable, Identifiable {
    @DocumentID var id: String?
    var projectId: String?
    var name: String?
    var target: Int?
    var allowOverlimit: Bool?
    var prerequisite: [String]?
}
