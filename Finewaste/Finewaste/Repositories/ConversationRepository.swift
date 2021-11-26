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
    
    func getConversation(including id: String) {
        store.collection(path)
            .whereField("users", arrayContains: id)
            .getDocuments { snapshot, _ in
                guard let docs = snapshot?.documents else {
                    return
                }
                
                self.conversations = docs.compactMap { try? $0.data(as: Conversation.self) }
            }
    }
    
    func add(conversation: Conversation, completion: @escaping (Conversation) -> Void) {
        checkExistingConversation(firstUserId: conversation.firstUserId,
                             secondUserId: conversation.secondUserId) { foundConversation in
            guard let existingConversation = foundConversation else {
                do {
                    let ref = self.store.collection(self.path).document()
                    try ref.setData(from: conversation) { _ in
                        completion(conversation)
                    }
                } catch {
                    
                }
                
                return
            }
            
            completion(existingConversation)
        }
    }
    
    private func checkExistingConversation(firstUserId: String, secondUserId: String, completion: @escaping (Conversation?) -> Void) {
        store.collection(path)
            .whereField("users", arrayContains: firstUserId)
            .getDocuments { snapshot, _ in
                guard let docs = snapshot?.documents else {
                    return
                }
                
                let conversations = docs.compactMap { try? $0.data(as: Conversation.self) }
                let filteredConversations = conversations.filter { $0.users.contains(secondUserId) }
                
                if filteredConversations.isEmpty {
                    completion(nil)
                    return
                }
                
                completion(filteredConversations.first)
            }
    }
}
