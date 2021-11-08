//
//  Message.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable {
    @DocumentID var id: String?
    var conversationId: String?
    var sender: String?
    var text: String?
    var isRead: Bool
    var attachmentUrl: String?
    @ServerTimestamp var timestamp: Timestamp?
}
