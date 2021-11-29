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
            if !messages.isEmpty {
                repository.markMessagesAsReaad(readerId: AuthenticationHelper.shared.userId, conversationId: conversationId)
                self.groupMessages()
            }
        }
    }
    @Published var groupedMessages = [(date: String, messages: [Message])]()
    
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
    
    private func groupMessages() {
        groupedMessages = []
        
        messages.forEach { message in
            let messageDate = UnixTimestampHelper.shared.unixTimestampToString(seconds: message.createdDate ?? 0, format: .dayDate)
            if let index = groupedMessages.firstIndex(where: {$0.date == messageDate}) {
                groupedMessages[index].messages.append(message)
            } else {
                groupedMessages.append((date: messageDate, messages: [message]))
            }
        }
    }
}
