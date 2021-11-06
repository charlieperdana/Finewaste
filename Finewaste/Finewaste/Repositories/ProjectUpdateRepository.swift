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
    
    init() {
        
    }
    
    func get(projectId: String) {
        store.collection(path)
            .whereField("projectId", isEqualTo: projectId)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    return
                }
                
                self.projectUpdates = documents.compactMap { try? $0.data(as: ProjectUpdate.self) }
            }
    }
}
