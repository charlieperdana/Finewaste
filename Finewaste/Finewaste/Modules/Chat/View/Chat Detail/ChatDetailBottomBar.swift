//
//  ChatDetailBottomBar.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI

struct ChatDetailBottomBar: View {
    @State private var messageToSend = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ChatTemplate(text: "Ready dropoff?")
                        .onTapGesture {
                            self.messageToSend = "Ready dropoff"
                        }
                    ChatTemplate(text: "Masih open?")
                        .onTapGesture {
                            self.messageToSend = "Masih open?"
                        }
                }
            }
            
            HStack(spacing: 8) {
                Button(action: attachFile) {
                    Image(systemName: "plus.app")
                        .font(.system(size: 22))
                        .foregroundColor(Colors.Turqoise)
                }
                
                TextField("Say something", text: $messageToSend)
                    .padding(.horizontal, 12)
                    .textFieldStyle(.plain)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Colors.PlaceholderGray)
                            .frame(height: 44)
                    )
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 22))
                        .foregroundColor(Colors.Red)
                }
            }
        }
    }
    
    private func attachFile() {
        
    }
    
    private func sendMessage() {
        
    }
}

struct ChatDetailBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailBottomBar()
    }
}
