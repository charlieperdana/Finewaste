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
    @State private var isSearching = false
    
    var body: some View {
        VStack(spacing: 16) {
            SearchBarView(searchText: $searchChatKeyword, isSearching: $isSearching, placeholderText: "Search chat history")
            
            VStack(spacing: 0) {
                ForEach(viewModel.sortedConversations, id: \.id) { conversation in
                    ChatItem(
                        conversation: conversation,
                        isPinned: viewModel.isCurrentChatPinned(conversation: conversation),
                        onPinTapped: {
                            viewModel.changePinState(for: conversation)
                        },
                        onDeleteTapped: {
                            viewModel.deleteConversation(for: conversation)
                        }
                    )
                }
            }
            
            Spacer()
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
