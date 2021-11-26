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
    var id: UUID = UUID()
    var senderId: String
    var text: String
    var isRead: Bool = false
    var isDelivered: Bool = false
    var attachmentUrls: [String]?
    var createdDate: Int64?
    
    enum CodingKeys: String, CodingKey {
        case senderId, text, isRead, isDelivered, attachmentUrls, createdDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.senderId = try container.decode(String.self, forKey: .senderId)
        self.text = try container.decode(String.self, forKey: .text)
        self.isRead = try container.decode(Bool.self, forKey: .isRead)
        self.isDelivered = try container.decode(Bool.self, forKey: .isDelivered)
        self.attachmentUrls = try container.decodeIfPresent([String].self, forKey: .attachmentUrls) ?? []
        self.createdDate = try container.decodeIfPresent(Int64.self, forKey: .createdDate)
    }
    
    init(senderId: String, text: String) {
        self.senderId = senderId
        self.text = text
    }
}
