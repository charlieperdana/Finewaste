//
//  FinewasteImagePicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

struct FinewasteImagePicker: View {
    var items: [GridItem] {
        Array(repeating: .init(.fixed(100), spacing: 16), count: 3)
    }
    
    @Binding var selectedImages: [UIImage]
    
    @State private var showImagePicker = false
    @State private var showActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        LazyVGrid(columns: items, alignment: .leading, spacing: 13) {
            ForEach(0..<selectedImages.count + 1, id: \.self) { index in
                if index == 0 {
                    AddImageView {
                        self.showActionSheet = true
                    }
                } else {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: selectedImages[index - 1])
                            .centerWidthCrop()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Button {
                            self.removeImage(at: index - 1)
                        } label: {
                            Image("deleteIcon")
                                .foregroundColor(Colors.Red)
                                .font(.system(size: 17))
                                .zIndex(1)
                        }
                        .offset(x: 7, y: -5)
                    }
                    .frame(width: 100, height: 100)
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            MultiPhotoPicker(pickerResult: $selectedImages)
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Choose your image source"), buttons: [
                ActionSheet.Button.default(Text("Camera"), action: {
                    self.imageSource = .camera
                    self.showImagePicker = true
                }),
                ActionSheet.Button.default(Text("Photo Library"), action: {
                    self.imageSource = .photoLibrary
                    self.showImagePicker = true
                }),
                ActionSheet.Button.cancel()
            ])
        }
    }
    
    private func removeImage(at index: Int) {
        withAnimation {
            self.selectedImages.remove(at: index)
        }
    }
}

struct FinewasteImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteImagePicker(selectedImages: .constant([]))
    }
}
