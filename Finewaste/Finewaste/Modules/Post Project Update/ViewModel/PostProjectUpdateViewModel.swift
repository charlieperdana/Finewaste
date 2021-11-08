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
        
        repository.post(update: update, images: imagesData)
    }
}
