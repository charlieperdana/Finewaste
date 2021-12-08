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
            if !conversations.isEmpty {
                sortConversationBypinState()
            }
        }
    }
    @Published var sortedConversations = [Conversation]()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var pinnedChatIds = [String]()
    
    init() {
        conversationRepository.$conversations
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
    
    func isCurrentChatPinned(conversation: Conversation) -> Bool {
        return pinnedChatIds.contains(conversation.id ?? "---")
    }
    
    func changePinState(for conversation: Conversation) {
        let conversationId = conversation.id ?? "---"
        if pinnedChatIds.contains(conversationId) {
            guard let index = pinnedChatIds.firstIndex(of: conversationId) else {
                return
            }
            pinnedChatIds.remove(at: index)
        } else {
            pinnedChatIds.append(conversationId)
        }
        
        LocalChatData.shared.pinnedChatIds = pinnedChatIds
        sortConversationBypinState()
    }
    
    func deleteConversation(for conversation: Conversation) {
        
    }
}
