//
//  ChatBubble.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI

struct ChatBubble<Content>: View where Content: View {
    let direction: MessageBubbleShape.Direction
    let content: () -> Content
    
    init(direction: MessageBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.direction = direction
    }
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            content()
                .clipShape(MessageBubbleShape(direction: direction))
            if direction == .left {
                Spacer()
            }
        }
        .padding([(direction == .left) ? .leading : .trailing, .top, .bottom], 10)
        .padding((direction == .right) ? .leading : .trailing, 70)
    }
}
