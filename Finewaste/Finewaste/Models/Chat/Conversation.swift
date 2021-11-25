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
    var firstUserId: String
    var firstUserName: String
    var firstUserPhotoUrl: String
    var secondUserId: String
    var secondUserName: String
    var secondUserPhotoUrl: String
    var users: [String]
    var lastMessage: String = ""
    var unreadMessages: Int = 0
}
