//
//  MessageRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 25/11/21.
//

import FirebaseDatabase
import Foundation

class MessageRepository: ObservableObject {
    private let path = "messages"
    private let url = "https://finewaste-default-rtdb.asia-southeast1.firebasedatabase.app"
    private let ref: DatabaseReference!
    
    @Published var messages = [Message]()
    private var otherSideMessageIds = [String]()
    
    init() {
        ref = Database.database(url: self.url).reference()
    }
    
    func add(message: Message, toConversationId conversationId: String) {
        ref.child(path)
            .child(conversationId)
            .child(UUID().uuidString)
            .setValue([
                "senderId": message.senderId,
                "text": message.text,
                "isRead": false,
                "isDelivered": false,
                "attachmentUrls": message.attachmentUrls ?? [],
                "createdDate": ServerValue.timestamp()
            ])
    }
    
    func getMessages(fromConversationId id: String) {
        let messagePath = "\(path)/\(id)"
        ref.child(messagePath).observe(.value) { snapshot in
            guard let messages = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                self.messages = try messages.compactMap { message in
                    if let messageValue = message.value as? [String: Any] {
                        let jsonData = try JSONSerialization.data(withJSONObject: messageValue, options: [])
                        let messageModel = try JSONDecoder().decode(Message.self, from: jsonData)
                        
                        if messageModel.senderId != AuthenticationHelper.shared.userId {
                            self.otherSideMessageIds.append(message.key)
                        }

                        return messageModel
                    }
                    
                    return nil
                }
                
                self.messages.sort {
                    ($0.createdDate ?? -1) < ($1.createdDate ?? -1)
                }
            } catch {
                
            }
        }
    }
    
    func markMessagesAsReaad(readerId: String, conversationId: String) {
        if otherSideMessageIds.isEmpty {
            return
        }
        
        otherSideMessageIds.forEach { messageId in
            let messagePath = "\(path)/\(conversationId)/\(messageId)"
            let messageRef = ref.child(messagePath)
            
            messageRef.updateChildValues([
                "isRead": true
            ])
        }
    }
}
