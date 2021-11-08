//
//  Conversation.swift
//  Finewaste
//
//  Created by Andrean Lay on 05/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Conversation: Codable, Identifiable {
    @DocumentID var id: String?
    var users: [String]?
}
