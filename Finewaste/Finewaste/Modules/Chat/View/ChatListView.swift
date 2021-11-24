//
//  ChatListView.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatListViewModel()
    @State private var searchChatKeyword = ""
    
    var body: some View {
        VStack(spacing: 16) {
            FinewasteSearchbar(placeholderText: "Search chat history", searchText: $searchChatKeyword)
            
            VStack(spacing: 0) {
                ForEach(0..<2, id: \.self) { index in
                    ChatItem(
                        senderName: "Ali Abdul",
                        lastMessage: "Hellooo",
                        isPinned: true,
                        onPinTapped: {
                            
                        },
                        onDeleteTapped: {
                            
                        }
                    )
                }
            }
        }
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
