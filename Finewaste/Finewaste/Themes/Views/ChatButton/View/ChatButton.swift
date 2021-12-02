//
//  ChatButton.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI

struct ChatButton: View {
    @State private var isShowingConversationPage = false
    @State private var isShowingLoginModal = false
    @StateObject private var viewModel: ChatButtonViewModel
    
    @State private var conversationId = ""
    @State private var displayName = ""
    @State private var photoUrl = ""
    
    private var receiverId: String
    
    init(receiverId: String, receiverName: String, receiverPhotoUrl: String) {
        self.receiverId = receiverId
        
        self._viewModel = StateObject(wrappedValue: ChatButtonViewModel(receiverId: receiverId, receiverName: receiverName, receiverPhotoUrl: receiverPhotoUrl))
    }
    
    var body: some View {
        Group {
            NavigationLink(destination: ChatDetailView(conversationId: conversationId, receiverId: receiverId, receiverDisplayName: displayName, receiverPhotoUrl: photoUrl), isActive: $isShowingConversationPage) {
                EmptyView()
            }
            FinewasteButtonFill(text: "Chat", size: .small, isEnabled: true) {
                if !AuthenticationHelper.shared.isLoggedIn {
                    isShowingLoginModal.toggle()
                    return
                }
                
                viewModel.createConversationIfNotExists { id, displayName, photoUrl in
                    self.conversationId = id
                    self.displayName = displayName
                    self.photoUrl = photoUrl
                    
                    self.isShowingConversationPage.toggle()
                }
            }
        }
        .sheet(isPresented: $isShowingLoginModal) {
            LoginView(loginTrigger: .chat)
        }
    }
}

struct ChatButton_Previews: PreviewProvider {
    static var previews: some View {
        ChatButton(receiverId: "", receiverName: "", receiverPhotoUrl: "")
    }
}
