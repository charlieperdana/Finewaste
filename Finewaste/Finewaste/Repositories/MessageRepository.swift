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
                    if let message = message.value as? [String: Any] {
                        let jsonData = try JSONSerialization.data(withJSONObject: message, options: [])
                        let message = try JSONDecoder().decode(Message.self, from: jsonData)

                        return message
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
}
