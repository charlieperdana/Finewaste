//
//  SelectMaterialViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import Combine

class SelectMaterialViewModel: ObservableObject {
    private var repository = ProjectMaterialRepository()
    @Published var projectMaterials = [ProjectMaterial]()
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var contributionModel: NewContributionModel
    
    init(contributionModel: NewContributionModel) {
        self.contributionModel = contributionModel
        
        repository.$materials
            .sink { materials in
                var contributionMaterials = [NewContributionMaterialModel]()
                
                if contributionModel.materials.isEmpty {
                    materials.forEach { material in
                        let contributionMaterial = NewContributionMaterialModel()
                        contributionMaterial.materialId = material.id ?? "---"
                        contributionMaterial.materialName = material.name ?? "---"
                        contributionMaterial.requirements = material.prerequisite ?? []
                        
                        contributionMaterials.append(contributionMaterial)
                    }
                    self.contributionModel.materials = contributionMaterials
                }

                
                self.projectMaterials = materials
            }
            .store(in: &cancellables)
        
        repository.getMaterials(projectId: contributionModel.postId)
    }
}
