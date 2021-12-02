//
//  ChatDetailViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation
import Combine
import UIKit

class ChatDetailViewModel: ObservableObject {
    private var conversationRepository = ConversationRepository()
    private var messageRepository = MessageRepository()
    private var conversationId: String
    private var receiverId: String
    
    var currentUser = AuthenticationHelper.shared.userId
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var messages = [Message]() {
        didSet {
            if !messages.isEmpty {
                messageRepository.markMessagesAsReaad(readerId: AuthenticationHelper.shared.userId, conversationId: conversationId)
                self.groupMessages()
                self.resetReadCount()
            }
        }
    }
    @Published var groupedMessages = [(date: String, messages: [Message])]()
    
    init(conversationId: String, receiverId: String) {
        self.conversationId = conversationId
        self.receiverId = receiverId
        
        messageRepository.$messages
            .assign(to: \.messages, on: self)
            .store(in: &cancellables)
        messageRepository.getMessages(fromConversationId: conversationId)
    }
    
    func sendMessage(text: String, images: [UIImage]) {
        if images.isEmpty {
            let message = Message(senderId: currentUser, text: text)
            messageRepository.add(message: message, toConversationId: conversationId)
        } else {
            let compressedImages = ImageCompressor.shared.compressImages(images: images)
            let message = Message(senderId: currentUser, text: "")
            messageRepository.addAttachment(message: message, attachments: compressedImages, toConversationId: conversationId) {
                
            }
        }
    }
    
    func markMessagesAsRead() {
        messageRepository.markMessagesAsReaad(readerId: currentUser, conversationId: conversationId)
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
    
    private func resetReadCount() {
        conversationRepository.resetReadCount(conversationId: conversationId, senderId: receiverId)
    }
}
