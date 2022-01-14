//
//  ChatButtonViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation

class ChatButtonViewModel: ObservableObject {
    private var repository = ConversationRepository()
    
    private var currentId = AuthenticationHelper.shared.userId
    private var currentName = AuthenticationHelper.shared.displayName
    private var currentPhotoUrl = AuthenticationHelper.shared.profilePhotoUrl
    private var receiverId: String
    private var receiverName: String
    private var receiverPhotoUrl: String
    
    init(receiverId: String, receiverName: String, receiverPhotoUrl: String) {
        self.receiverId = receiverId
        self.receiverName = receiverName
        self.receiverPhotoUrl = receiverPhotoUrl
    }
    
    func createConversationIfNotExists(completion: @escaping (String, String, String) -> Void) {
        let conversation = Conversation(firstUserId: currentId,
                                        firstUserName: currentName,
                                        firstUserPhotoUrl: currentPhotoUrl,
                                        secondUserId: receiverId,
                                        secondUserName: receiverName,
                                        secondUserPhotoUrl: receiverPhotoUrl,
                                        users: [currentId, receiverId])
        
        repository.add(conversation: conversation) { conversation in
            guard let conversationId = conversation.id else {
                return
            }
            // Check if current user is stored in firstUser variable
            // in the model
            if self.currentId == conversation.firstUserId {
                completion(conversationId, conversation.secondUserName, conversation.secondUserPhotoUrl)
            } else {
                completion(conversationId, conversation.firstUserName, conversation.firstUserPhotoUrl)
            }
        }
    }
    
}
