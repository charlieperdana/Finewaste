//
//  ProfileImagePicker.swift
//  Finewaste
//
//  Created by charlie siagian on 18/11/21.
//

import SwiftUI

struct ProfileImagePicker: View {
    @Binding var selectedImages: UIImage?
    @Binding var isLoadLocal: Bool
    
    @State private var showImagePicker = false
    @State private var showActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        VStack{
            FinewasteRoundedOutlineButton(text: "Change Profile Image", size: .fullWidth) {
                self.showActionSheet = true
            }
            
        }
        .sheet(isPresented: $showImagePicker) {
            NativeImagePicker(imageSource: self.imageSource) { selectedImage in
                self.selectedImages = selectedImage
                self.isLoadLocal = true
            }
        }
        .actionSheet(isPresented: $showActionSheet) { 
            ActionSheet(title: Text(""), buttons: [
                ActionSheet.Button.destructive(Text("Remove Current Photo"), action: {
                    
                }),
                ActionSheet.Button.default(Text("Take Photo"), action: {
                    self.imageSource = .camera
                    self.showImagePicker = true
                }),
                ActionSheet.Button.default(Text("Choose From Library"), action: {
                    self.imageSource = .photoLibrary
                    self.showImagePicker = true
                }),
                ActionSheet.Button.cancel()
            ])
        }
        

    }
}

struct ProfileImagePicker_Previews: PreviewProvider {
    @State static var imageSample : UIImage? = UIImage(named: "profile")
    @State static var isLoadLocal = true
    
    static var previews: some View {
        ProfileImagePicker(selectedImages: $imageSample, isLoadLocal: $isLoadLocal)
    }
}
