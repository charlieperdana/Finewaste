//
//  ProjectUpdate.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProjectUpdate: Codable, Identifiable {
    @DocumentID var id: String?
    var projectId: String?
    @ServerTimestamp var createdDate: Timestamp?
    var description: String?
    var images: [String]?
}
