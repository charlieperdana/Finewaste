//
//  ContributionMaterialRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class ContributionMaterialRepository: ObservableObject {
    private let path = "contributionMaterials"
    private let store = Firestore.firestore()
    @Published var contributionMaterials = [ContributionMaterial]()
    
    init() {
        
    }
    
    func getContributionMaterials(contributionIds: [String]) {
        store.collection(path)
            .whereField("contributionId", in: contributionIds)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    return
                }
                
                self.contributionMaterials = documents.compactMap { try? $0.data(as: ContributionMaterial.self) }
            }
    }
}
