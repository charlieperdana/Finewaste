//
//  ProjectUpdateRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class ProjectUpdateRepository: ObservableObject {
    private let path = "projectUpdates"
    private let store = Firestore.firestore()
    @Published var projectUpdates = [ProjectUpdate]()
    
    private var uploader: CloudStorageUploader?
    
    init() {
        
    }
    
    func get(projectId: String) {
        store.collection(path)
            .whereField("projectId", isEqualTo: projectId)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    return
                }

                var updates = documents.compactMap { try? $0.data(as: ProjectUpdate.self) }
                updates = updates.sorted(by: {
                    if let firstDate = $0.createdDate, let secondDate = $1.createdDate {
                        return firstDate.seconds > secondDate.seconds
                    }
                    
                    return false
                })
                
                self.projectUpdates = updates
            }
    }
    
    func post(update: ProjectUpdate, images: [Data], onUpdate: @escaping () -> Void) {
        let ref = store.collection(path).document()
        var updatedProject = update
        
        uploader = CloudStorageUploader(toUpload: images, onUploadedHandler: onUpdate)
        uploader?.startUpload(atPath: "\(path)/\(ref.documentID)") { imageLinks in
            updatedProject.images = imageLinks
            
            do {
                try ref.setData(from: updatedProject) { _ in
                    // Document added..
                }
            } catch {
                
            }
        }
    }
    
    func cancelUpload() {
        if let uploader = self.uploader {
            uploader.canceUpload()
        }
    }
}
