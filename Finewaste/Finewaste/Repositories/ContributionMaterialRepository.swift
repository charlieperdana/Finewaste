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
    
    private var uploader: CloudStorageUploader?
    
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
    
    func postContributionMaterial(material: ContributionMaterial, images: [Data], onUpdate: @escaping () -> Void) {
        let ref = store.collection(path).document()
        var updatedMaterial = material
        
        uploader = CloudStorageUploader(toUpload: images, onUploadedHandler: onUpdate)
        uploader?.startUpload(atPath: "\(path)/\(ref.documentID)") { imageLinks in
            updatedMaterial.images = imageLinks
            
            do {
                try ref.setData(from: updatedMaterial) { _ in
                    // Document added..
                }
            } catch {
                
            }
        }
    }
    
    func cancelContributionMaterialUpload() {
        if let uploader = self.uploader {
            uploader.canceUpload()
        }
    }
}
