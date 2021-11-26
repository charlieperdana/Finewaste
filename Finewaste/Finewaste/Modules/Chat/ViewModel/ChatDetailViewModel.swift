//
//  ChatDetailViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation
import Combine

class ChatDetailViewModel: ObservableObject {
    private var repository = MessageRepository()
    private var conversationId: String
    
    var currentUser = AuthenticationHelper.shared.userId
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var messages = [Message]() {
        didSet {
            repository.markMessagesAsReaad(readerId: AuthenticationHelper.shared.userId, conversationId: conversationId)
        }
    }
    
    init(conversationId: String) {
        self.conversationId = conversationId
        
        repository.$messages
            .assign(to: \.messages, on: self)
            .store(in: &cancellables)
        repository.getMessages(fromConversationId: conversationId)
    }
    
    func sendMessage(text: String) {
        let message = Message(senderId: currentUser, text: text)
        
        repository.add(message: message, toConversationId: conversationId)
    }
    
    func markMessagesAsRead() {
        repository.markMessagesAsReaad(readerId: currentUser, conversationId: conversationId)
    }
}
