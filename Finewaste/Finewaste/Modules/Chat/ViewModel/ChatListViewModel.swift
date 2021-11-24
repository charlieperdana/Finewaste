//
//  ChatListViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation

class ChatListViewModel: ObservableObject {
    private var repository = ConversationRepository()
    
    private var currentUserId = AuthenticationHelper.shared.userId
    
    init() {
        
    }
}
