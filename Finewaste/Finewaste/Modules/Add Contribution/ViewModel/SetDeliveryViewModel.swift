//
//  SetDeliveryViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import Combine

class SetDeliveryViewModel: ObservableObject {
    private var repository = ProjectRepository()
    private var project: Project? {
        didSet {
            if project != nil {
                self.deliveryTypes = project?.deliveryType ?? []
                self.location = (project?.location?.latitude ?? 0, project?.location?.longitude ?? 0)
            }
        }
    }
    
    @Published var deliveryTypes = [String]()
    @Published var location: (Double, Double) = (-1, -1)
    
    @Published var contributionModel: NewContributionModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(contributionModel: NewContributionModel) {
        self.contributionModel = contributionModel
        
        repository.$project
            .assign(to: \.project, on: self)
            .store(in: &cancellables)
        repository.get(projectId: contributionModel.postId)
    }
}
