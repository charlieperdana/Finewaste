//
//  PostProjectUpdateViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import UIKit

class PostProjectUpdateViewModel: ObservableObject {
    private var repository = ProjectUpdateRepository()
    private var projectId: String
    
    @Published var postingUpdate = false
    @Published var uploadedImages = 0
    var totalImages = 0
    
    init(projectId: String) {
        self.projectId = projectId
    }
    
    func postUpdate(updateDescription: String, images: [UIImage]) {
        let update = ProjectUpdate(projectId: self.projectId, description: updateDescription)

        var imagesData = [Data]()
        images.forEach { image in
            if let compressedImageData = image.jpegData(compressionQuality: 0.8) {
                imagesData.append(compressedImageData)
            }
        }

        self.totalImages = imagesData.count
        self.postingUpdate = true
        repository.post(update: update, images: imagesData) { [self] in
            uploadedImages += 1

            if uploadedImages == imagesData.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.postingUpdate = false
                }
            }
        }
    }
    
    func cancelPostUpdate() {
        repository.cancelUpload()
        self.postingUpdate = false
        uploadedImages = 0
    }
}
