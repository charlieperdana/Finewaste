//
//  LocalChatData.swift
//  Finewaste
//
//  Created by Andrean Lay on 08/12/21.
//

import Foundation

final class LocalChatData {
    static let shared = LocalChatData()
    private let pinnedChatKey = "PINNED_CHAT_KEY"
    
    private init() {
        
    }
    
    var pinnedChatIds: [String] {
        get {
            if let pinnedChat = UserDefaults.standard.object(forKey: pinnedChatKey) as? [String] {
                return pinnedChat
            }
            
            return []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: pinnedChatKey)
        }
    }
}
