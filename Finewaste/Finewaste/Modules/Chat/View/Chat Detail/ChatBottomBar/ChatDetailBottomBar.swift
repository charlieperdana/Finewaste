//
//  ChatDetailBottomBar.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI

struct ChatDetailBottomBar: View {
    @ObservedObject var viewModel: ChatDetailViewModel
    @State private var messageToSend = ""
    @State private var selectedImages = [UIImage]()
    
    @State private var isShowingActionSheet = false
    @State private var isShowingCamera = false
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ChatTemplate(text: "Ready dropoff?")
                        .onTapGesture {
                            self.messageToSend = "Ready dropoff?"
                        }
                    ChatTemplate(text: "Masih open?")
                        .onTapGesture {
                            self.messageToSend = "Masih open?"
                        }
                }
            }
            
            HStack(alignment: .bottom, spacing: 8) {
                Button(action: attachImage) {
                    Image(systemName: "plus.app")
                        .font(.system(size: 22))
                        .foregroundColor(Colors.Turqoise)
                }
                
                if selectedImages.isEmpty {
                    TextField("Say something", text: $messageToSend)
                        .padding(.horizontal, 12)
                        .textFieldStyle(.plain)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Colors.PlaceholderGray)
                                .frame(height: 44)
                        )
                } else {
                    ImageListField(selectedImages: $selectedImages)
                }
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 22))
                        .foregroundColor((messageToSend.isEmpty && selectedImages.isEmpty) ? Colors.Gray : Colors.Red)
                }
                .disabled(messageToSend.isEmpty && selectedImages.isEmpty)
            }
        }
        .sheet(isPresented: $isShowingCamera) {
            NativeImagePicker(imageSource: .camera) { selectedImage in
                self.selectedImages.insert(selectedImage, at: 0)
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            MultiPhotoPicker(pickerResult: $selectedImages)
        }
        .actionSheet(isPresented: $isShowingActionSheet) {
            ActionSheet(title: Text("Choose your image source"), buttons: [
                ActionSheet.Button.default(Text("Camera"), action: {
                    self.isShowingCamera = true
                }),
                ActionSheet.Button.default(Text("Photo Library"), action: {
                    self.isShowingImagePicker = true
                }),
                ActionSheet.Button.cancel()
            ])
        }
    }
    
    private func attachImage() {
        self.isShowingActionSheet = true
    }
    
    private func sendMessage() {
        viewModel.sendMessage(text: messageToSend, images: selectedImages)
        messageToSend = ""
    }
}

struct ChatDetailBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailBottomBar(viewModel: ChatDetailViewModel(conversationId: "", receiverId: ""))
    }
}
