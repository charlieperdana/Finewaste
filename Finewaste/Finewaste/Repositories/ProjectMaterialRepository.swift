//
//  ProjectMaterialRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 05/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ProjectMaterialRepository: ObservableObject {
    private let path = "projectMaterials"
    private let store = Firestore.firestore()
    
    @Published var materials: [ProjectMaterial] = []
    
    init() {
        
    }
    
    func getMaterials(projectId: String) {
        store.collection(path)
            .whereField("projectId", isEqualTo: projectId)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    return
                }
                
                self.materials = documents.compactMap { try? $0.data(as: ProjectMaterial.self) }
            }
    }
}
