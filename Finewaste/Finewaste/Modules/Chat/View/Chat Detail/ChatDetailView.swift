//
//  ChatDetailView.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI
import Kingfisher

struct SwipeableChatBubbble: ViewModifier {
    var side: MessageBubbleShape.Direction
    var swipeOffset: CGFloat
    
    func body(content: Content) -> some View {
        if side == .right {
            content
                .offset(x: swipeOffset)
        } else {
            content
        }
    }
}

struct ChatDetailView: View {
    private var texts = [
        "Halo, I want to upcycle my waste",
        "Sure, what do you want to upcycle?",
        "Denim."
    ]
    
    @StateObject private var viewModel: ChatDetailViewModel
    
    private var receiverDisplayName: String
    private var receiverPhotoUrl: String
    private var receiverId: String
    
    @State private var dragOffset: CGFloat = 0
    
    init(conversationId: String, receiverId: String, receiverDisplayName: String, receiverPhotoUrl: String) {
        self._viewModel = StateObject(wrappedValue: ChatDetailViewModel(conversationId: conversationId, receiverId: receiverId))
        
        self.receiverDisplayName = receiverDisplayName
        self.receiverPhotoUrl = receiverPhotoUrl
        self.receiverId = receiverId
    }
    
    var body: some View {
        VStack {
            ChatDetailNavigationBar(displayName: receiverDisplayName, photoUrl: receiverPhotoUrl, receiverId: receiverId)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.groupedMessages, id: \.date) { group in
                        Text(group.date)
                            .font(Fonts.poppinsCaption2())
                        
                        ForEach(group.messages, id: \.id) { message in
                            let chatSide: MessageBubbleShape.Direction = message.senderId != viewModel.currentUser ? .left : .right
                            
                            VStack(alignment: .trailing, spacing: 0) {
                                
                                ZStack {
                                    HStack {
                                        Spacer()
                                        Text(message.formattedTime)
                                            .font(Fonts.poppinsCaption2())
                                            .offset(x: 30)
                                    }
                                    .offset(x: dragOffset)
                                    
                                    ChatBubble(direction: chatSide) {
                                        Group {
                                            if !message.attachmentUrls.isEmpty {
                                                NavigationLink(destination: ImageGalleryView(updatePostedDate: "Images", images: message.attachmentUrlObjects, chosenIndex: 0)) {
                                                    KFImage(URL(string: message.attachmentUrls[0]))
                                                        .cropToSize(width: 246, height: 312)
                                                }
                                            } else {
                                                Text(message.text)
                                                    .foregroundColor(Colors.ChatBubbleText)
                                                    .padding(.vertical, 8)
                                            }
                                        }
                                        .font(Fonts.poppinsBody())
                                        .padding(chatSide == .right ? .leading : .trailing, 12)
                                        .padding(chatSide == .right ? .trailing : .leading)
                                        .background(chatSide == .left ? Colors.OtherUserChatBubble : Colors.UserChatBubble)
                                    }
                                    .modifier(SwipeableChatBubbble(side: chatSide, swipeOffset: dragOffset))
                                }
                                .animation(.linear)
                                .contentShape(Rectangle())
                                .gesture(
                                    DragGesture()
                                        .onChanged { val in
                                            if val.translation.width > -50 && val.translation.width < 0 {
                                                self.dragOffset = val.translation.width
                                            }
                                        }
                                        .onEnded { _ in
                                            self.dragOffset = 0
                                        }
                                )
                                
                                if chatSide == .right && message.isRead {
                                    Text("Read")
                                        .font(Fonts.poppinsCaption2())
                                        .foregroundColor(Colors.Turqoise)
                                        .offset(x: -20)
                                }
                            }
                        }
                    }
                }
            }
            
            ChatDetailBottomBar(viewModel: viewModel)
                .padding()
        }
        .navigationBarHidden(true)
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView(conversationId: "", receiverId: "", receiverDisplayName: "", receiverPhotoUrl: "")
    }
}
