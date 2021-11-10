//
//  ProjectRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 01/11/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class ProjectRepository: ObservableObject {
    private let path = "projects"
    private let store = Firestore.firestore()
    @Published var project: Project?
    
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
}
