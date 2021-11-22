//
//  ContributionRepository.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class ContributionRepository: ObservableObject {
    private let path = "contributions"
    private let store = Firestore.firestore()
    @Published var contributions = [Contribution]()
    
    init() {

    }
    
    func getContributions(projectId: String) {
        store.collection(path)
            .whereField("projectId", isEqualTo: projectId)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    return
                }
                
                self.contributions = documents.compactMap { try? $0.data(as: Contribution.self) }
            }
    }
    
    func getUserContribution(userID: String) {
        let firestore = Firestore.firestore()
        firestore.collection("contributions").whereField("contributor", isEqualTo: userID).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                return
            }
            
            self.contributions = documents.compactMap { try? $0.data(as: Contribution.self) }
        }
    }
    
    func postContribution(contribution: Contribution, completion: @escaping (String) -> Void) {
        do {
            let ref = store.collection(path).document()
            try ref.setData(from: contribution) { err in
                if err == nil {
                    completion(ref.documentID)
                }
            }
        } catch {
            
        }
    }
}
