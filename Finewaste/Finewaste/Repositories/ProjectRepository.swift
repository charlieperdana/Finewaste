//
//  ProjectRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 01/11/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class ProjectRepository: ObservableObject {
    private let path = "projects"
    private let store = Firestore.firestore()
    
    @Published var project: Project?
    @Published var projects = [Project]()
    
    @Published var documentId = ""
    
    private var uploader: CloudStorageUploader?
    
    init() {

    }
    
    func get(projectId: String) {
        store.collection(path)
            .document(projectId)
            .addSnapshotListener { snapshot, err in
                if let error = err {
                    print(error)
                    return
                }
                
                self.project = try? snapshot?.data(as: Project.self)
        }
    }
    
    func getProjects(poster: String) {
        store.collection(path)
            .whereField("poster", isEqualTo: poster)
            .addSnapshotListener { snapshot, err in
                guard let documents = snapshot?.documents else {
                    return
                }
                
                self.projects = documents.compactMap { try? $0.data(as: Project.self) }
            }
    }
    
    func postProject(project: Project, images: [Data], onUpdate: @escaping () -> Void, completion: @escaping (String) -> Void) {
        let ref = store.collection(path).document()
        var updatedProject = project
        
        uploader = CloudStorageUploader(toUpload: images, onUploadedHandler: onUpdate)
        uploader?.startUpload(atPath: "\(path)/\(ref.documentID)") { imageLinks in
            updatedProject.images = imageLinks
            print("abcdefg \(imageLinks)")
            do {
                try ref.setData(from: updatedProject) { err in
                    if err == nil {
                        completion(ref.documentID)
                    }
                }
            } catch {
                
            }
        }
    }
}
