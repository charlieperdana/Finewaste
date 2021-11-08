//
//  CloudStorageUploader.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import FirebaseStorage

final class CloudStorageUploader {
    private let storage = Storage.storage().reference()
    private var uploadTask: StorageUploadTask?
    private var dataToUpload: [Data]
    private var uploadedUrls = [String]()
    
    init(toUpload: [Data]) {
        self.dataToUpload = toUpload
    }
    
    private func upload(index: Int, path: String, completion: @escaping () -> Void) {
        if index == dataToUpload.count {
            completion()
            return
        }
        
        let ref = storage.child("\(path)_\(index)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        self.uploadTask = ref.putData(dataToUpload[index], metadata: metadata) { _, _ in
            
            ref.downloadURL { [self] url, _ in
                guard let url = url else {
                    return
                }
                
                self.uploadedUrls.append(url.absoluteString)
                upload(index: index + 1, path: path, completion: completion)
            }
        }
    }
    
    func startUpload(atPath path: String, completion: @escaping ([String]) -> Void) {
        upload(index: 0, path: path) {
            completion(self.uploadedUrls)
        }
    }
}
