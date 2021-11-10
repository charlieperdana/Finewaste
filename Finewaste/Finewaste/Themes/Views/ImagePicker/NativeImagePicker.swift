//
//  NativeImagePicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

struct NativeImagePicker: UIViewControllerRepresentable {
    var imageSource: UIImagePickerController.SourceType
    var finishPickingImage: (_ image: UIImage) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = imageSource
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: NativeImagePicker
    
    init(_ parent: NativeImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.parent.finishPickingImage(image)
        }
        
        self.parent.presentationMode.wrappedValue.dismiss()
    }
}
