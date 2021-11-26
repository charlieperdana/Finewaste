//
//  ChatListViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    private var repository = ConversationRepository()
    
    private var currentUserId = AuthenticationHelper.shared.userId
    
    @Published var conversations = [Conversation]()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        repository.$conversations
            .assign(to: \.conversations, on: self)
            .store(in: &cancellables)
        
        repository.getConversation(including: currentUserId)
    }
}
