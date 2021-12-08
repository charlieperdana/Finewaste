//
//  ChatListViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    private var conversationRepository = ConversationRepository()
    
    private var currentUserId = AuthenticationHelper.shared.userId
    
    private var conversations = [Conversation]() {
        didSet {
            sortConversationBypinState()
        }
    }
    @Published var sortedConversations = [Conversation]()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var pinnedChatIds = [String]()
    
    init() {
        conversationRepository.$conversations
            .compactMap { convs in
                convs.filter {
                    !self.currentConversationIsDeleted(conversation: $0)
                }
            }
            .assign(to: \.conversations, on: self)
            .store(in: &cancellables)
        
        conversationRepository.getConversation(including: currentUserId)
        
        self.pinnedChatIds = LocalChatData.shared.pinnedChatIds
    }
    
    private func sortConversationBypinState() {
        sortedConversations = []
        var tempConversation = conversations
        pinnedChatIds.forEach { id in
            guard let chatIndex = tempConversation.firstIndex(where: {
                let conversationId = $0.id ?? "---"
                return conversationId == id
            }) else { return }
            
            sortedConversations.append(tempConversation[chatIndex])
            tempConversation.remove(at: chatIndex)
        }
        
        sortedConversations.append(contentsOf: tempConversation)
    }
    
    private func currentConversationIsDeleted(conversation: Conversation) -> Bool {
        let isFirstUser = conversation.firstUserId == currentUserId
        if isFirstUser {
            return conversation.firstUserDeletedChat
        } else {
            return conversation.secondUserDeletedChat
        }
    }
    
    func isCurrentChatPinned(conversation: Conversation) -> Bool {
        return pinnedChatIds.contains(conversation.id ?? "---")
    }
    
    func changePinState(for conversation: Conversation) {
        let conversationId = conversation.id ?? "---"
        if pinnedChatIds.contains(conversationId) {
            LocalChatData.shared.removePinStatus(id: conversationId)
        } else {
            LocalChatData.shared.pinChat(id: conversationId)
        }
        
        self.pinnedChatIds = LocalChatData.shared.pinnedChatIds
        sortConversationBypinState()
    }
    
    func deleteConversation(for conversation: Conversation) {
        var newData: [AnyHashable: Any] = [:]
        if conversation.firstUserId == currentUserId {
            newData["firstUserDeletedChat"] = true
        } else {
            newData["secondUserDeletedChat"] = true
        }
    
        let id = conversation.id ?? "---"
        conversationRepository.deleteChat(conversationId: id, deleteData: newData)
    }
}
