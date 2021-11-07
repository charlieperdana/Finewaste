//
//  FinewasteImagePicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

struct FinewasteImagePicker: View {
    var items: [GridItem] {
        Array(repeating: .init(.fixed(120)), count: 3)
    }
    
    @Binding var selectedImages: [UIImage]
    
    @State private var showImagePicker = false
    @State private var showActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: items, spacing: 13) {
                ForEach(0..<selectedImages.count + 1, id: \.self) { index in
                    if index == 0 {
                        AddImageView {
                            self.showActionSheet = true
                        }
                    } else {
                        Image(uiImage: selectedImages[index - 1])
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            NativeImagePicker(imageSource: self.imageSource) { selectedImage in
                self.selectedImages.insert(selectedImage, at: 0)
            }
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
}

struct FinewasteImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteImagePicker(selectedImages: .constant([]))
    }
}
