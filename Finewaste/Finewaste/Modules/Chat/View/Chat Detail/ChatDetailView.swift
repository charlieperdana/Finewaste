//
//  ChatDetailView.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatDetailView: View {
    private var texts = [
        "Halo, I want to upcycle my waste",
        "Sure, what do you want to upcycle?",
        "Denim."
    ]
    
    @StateObject private var viewModel: ChatDetailViewModel
    
    private var receiverDisplayName: String
    private var receiverPhotoUrl: String
    
    init(conversationId: String, receiverDisplayName: String, receiverPhotoUrl: String) {
        self._viewModel = StateObject(wrappedValue: ChatDetailViewModel(conversationId: conversationId))
        
        self.receiverDisplayName = receiverDisplayName
        self.receiverPhotoUrl = receiverPhotoUrl
    }
    
    var body: some View {
        VStack {
            ChatDetailNavigationBar(displayName: receiverDisplayName, photoUrl: receiverPhotoUrl)
            
            ScrollView {
                ForEach(texts.indices, id: \.self) { index in
                    let chatSide: MessageBubbleShape.Direction = index % 2 == 0 ? .left : .right
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        ChatBubble(direction: chatSide) {
                            Text(texts[index])
                                .foregroundColor(Colors.ChatBubbleText)
                                .font(Fonts.poppinsBody())
                                .padding(.vertical, 8)
                                .padding(chatSide == .right ? .leading : .trailing, 12)
                                .padding(chatSide == .right ? .trailing : .leading)
                                .background(chatSide == .left ? Colors.OtherUserChatBubble : Colors.UserChatBubble)
                        }
                        
                        if chatSide == .right {
                            Text("Read")
                                .font(Fonts.poppinsCaption2())
                                .foregroundColor(Colors.Turqoise)
                                .offset(x: -20)
                        }
                    }
                }
            }
            
            ChatDetailBottomBar()
                .padding()
        }
        .navigationBarHidden(true)
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView(conversationId: "", receiverDisplayName: "", receiverPhotoUrl: "")
    }
}
