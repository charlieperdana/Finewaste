//
//  ChatListView.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var tabBarManager: TabBarManager
    
    @State private var searchChatKeyword = ""
    
    var body: some View {
        VStack(spacing: 8) {
            FinewasteSearchbar(placeholderText: "Search chat history", searchText: $searchChatKeyword)
            
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
