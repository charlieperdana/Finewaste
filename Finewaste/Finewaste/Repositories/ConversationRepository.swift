//
//  ChatRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ConversationRepository: ObservableObject {
    private let path = "conversations"
    private let store = Firestore.firestore()
    
    @Published var conversations: [Conversation] = []
    
    init() {
        
    }
    
    func add(conversation: Conversation) {
        do {
            let ref = store.collection(path).document()
            try ref.setData(from: conversation)
        } catch {
            
        }
    }
}
