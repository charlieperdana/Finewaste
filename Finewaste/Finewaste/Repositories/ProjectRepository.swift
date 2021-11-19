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
}
