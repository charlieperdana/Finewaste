//
//  MyContributionsViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 12/11/21.
//

import Combine

class MyContributionsViewModel: ObservableObject {
    private var repository = ContributionRepository()
    @Published var contribution = [Contribution]()
    
    private var cancellables: Set<AnyCancellable> = []
    
    var contributionID: String
    
    init(contributionID: String) {
        self.contributionID = contributionID
        repository.$contributions
            .assign(to: \.contribution, on: self)
            .store(in: &cancellables)
        repository.getContributions(projectId: contributionID)
    }
}
