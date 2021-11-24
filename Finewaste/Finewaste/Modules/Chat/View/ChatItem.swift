//
//  ChatItem.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI

struct ChatItem: View {
    var senderName: String
    var lastMessage: String
    var isPinned: Bool
    
    var onPinTapped: () -> Void
    var onDeleteTapped: () -> Void
    
    @State private var swipeOffset: CGFloat = 0
    @State private var isShowingChatDetail = false
    
    var body: some View {
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                if value.translation.width < 0 {
                    swipeOffset = value.translation.width
                }
            }
            .onEnded { _ in
                if swipeOffset < -120 {
                    swipeOffset = -120
                } else {
                    swipeOffset = 0
                }
            }
        let tapGesture = TapGesture()
            .onEnded {
                self.isShowingChatDetail.toggle()
            }
        
        let simultaneousGesture = tapGesture.simultaneously(with: dragGesture)
        
        ZStack {
            NavigationLink(destination: ChatDetailView(), isActive: $isShowingChatDetail) {
                EmptyView()
            }
            
            HStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .fill(Colors.Turqoise)
                    .frame(width: 60)
                    .overlay(Image(systemName: "pin"))
                    .onTapGesture {
                        onPinTapped()
                        swipeOffset = 0
                    }
                Rectangle()
                    .fill(Colors.Red)
                    .frame(width: 60)
                    .overlay(Image(systemName: "trash"))
                    .onTapGesture {
                        onDeleteTapped()
                        swipeOffset = 0
                    }
            }
            .frame(height: 60)
            .foregroundColor(.white)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(senderName)
                            .font(Fonts.poppinsCallout())
                        Text(lastMessage)
                            .font(Fonts.poppinsFootnote())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    if isPinned {
                        Image(systemName: "pin")
                            .foregroundColor(.gray)
                    }
                    ZStack {
                        Circle()
                            .frame(width: 22, height: 22)
                            .foregroundColor(Colors.Red)
                        Text("22")
                            .font(Fonts.poppinsCaptionBold())
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                Rectangle()
                    .padding(.leading)
                    .frame(height: 1)
                    .foregroundColor(Colors.Separator)
            }
            .frame(height: 60)
            .background(Colors.White)
            .offset(x: swipeOffset)
            .animation(.linear)
            .gesture(simultaneousGesture)

        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

struct ChatItem_Previews: PreviewProvider {
    static var previews: some View {
        ChatItem(senderName: "", lastMessage: "", isPinned: false, onPinTapped: {}, onDeleteTapped: {})
    }
}
