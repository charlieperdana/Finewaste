//
//  MultiPhotoPicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 30/11/21.
//

import PhotosUI
import SwiftUI

struct MultiPhotoPicker: UIViewControllerRepresentable {
    @Binding var pickerResult: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 0
        
        let photoPickerViewController = PHPickerViewController(configuration: config)
        photoPickerViewController.delegate = context.coordinator
        
        return photoPickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: MultiPhotoPicker
        
        init(_ parent: MultiPhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, _ in
                        if let uiImage = newImage as? UIImage {
                            self?.parent.pickerResult.insert(uiImage, at: 0)
                        }
                    }
                }
            }
            
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
