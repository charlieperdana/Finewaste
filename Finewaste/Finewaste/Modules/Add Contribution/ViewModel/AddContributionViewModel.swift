//
//  AddContributionViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import Foundation
import FirebaseFirestore

class AddContributionViewModel: ObservableObject {
    private var contributionRepository = ContributionRepository()
    private var contributionMaterialRepository = ContributionMaterialRepository()
    @Published var contributionModel = NewContributionModel()
    
    @Published var postingContribution = false
    @Published var uploadedImages = 0
    @Published var totalImages = 0
    
    init(projectId: String, projectOwnerId: String, projectName: String) {
        self.contributionModel.projectId = projectId
        self.contributionModel.projectOwnerId = projectOwnerId
        self.contributionModel.projectName = projectName
    }
    
    func postContribution() {
        var totalQuantity = 0
        contributionModel.materials.forEach {
            totalQuantity += $0.quantity
        }
        
        let contribution = Contribution(
            contributorId: AuthenticationHelper.shared.userId,
            projectId: contributionModel.projectId,
            projectOwnerId: contributionModel.projectOwnerId,
            projectName: contributionModel.projectName,
            deliveryType: contributionModel.deliveryType,
            location: GeoPoint(latitude: contributionModel.location.latitude, longitude: contributionModel.location.longitude),
            totalMaterialsQuantity: totalQuantity)
        
        contributionRepository.postContribution(contribution: contribution) { docId in
            var materials = [ContributionMaterial]()
            for material in self.contributionModel.materials where material.quantity != -1 {
                materials.append(
                    ContributionMaterial(contributionId: docId, name: material.materialName, quantity: material.quantity, images: [])
                )
                self.totalImages += material.images.count
            }
            
            self.postingContribution = true
            for index in materials.indices {
                let compressedImage = ImageCompressor.shared.compressImages(images: self.contributionModel.materials[index].images)
                
                self.contributionMaterialRepository.postContributionMaterial(material: materials[index], images: compressedImage) {
                    self.uploadedImages += 1
                    
                    if self.uploadedImages == self.totalImages {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.postingContribution = false
                        }
                    }
                }
            }
        }
    }
    
    func cancelPostContribution() {
        contributionMaterialRepository.cancelContributionMaterialUpload()
        postingContribution = false
        uploadedImages = 0
        totalImages = 0
    }
}
