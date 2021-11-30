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
    var unreadMessages: [String: Int] = [:]
    
    var otherUserName: String {
        return firstUserId == AuthenticationHelper.shared.userId ? secondUserName : firstUserName
    }
    
    var otherUserId: String {
        return firstUserId == AuthenticationHelper.shared.userId ? secondUserId : firstUserId
    }
    
    var otherProfilePhotoUrl: String {
        return firstUserId == AuthenticationHelper.shared.userId ? secondUserPhotoUrl : firstUserPhotoUrl
    }
    
    init(firstUserId: String, firstUserName: String, firstUserPhotoUrl: String, secondUserId: String, secondUserName: String, secondUserPhotoUrl: String, users: [String]) {
        self.firstUserId = firstUserId
        self.firstUserName = firstUserName
        self.firstUserPhotoUrl = firstUserPhotoUrl
        self.secondUserId = secondUserId
        self.secondUserName = secondUserName
        self.secondUserPhotoUrl = secondUserPhotoUrl
        self.users = users
    }
    
    init() {
        self.firstUserId = ""
        self.firstUserName = ""
        self.firstUserPhotoUrl = ""
        self.secondUserId = ""
        self.secondUserName = ""
        self.secondUserPhotoUrl = ""
        self.users = []
    }
}
