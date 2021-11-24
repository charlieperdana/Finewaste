//
//  HistoryProjectsViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 22/11/21.
//

import Combine

class HistoryProjectsViewModel: ObservableObject {
    private var contributionRepository = ContributionRepository()
    
    @Published var contributions = [Contribution]()
    
    private var currentUser = AuthenticationHelper.shared.userId
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        contributionRepository.$contributions
            .map { contributions in
                contributions.filter {
                    !($0.archived ?? false) || ($0.status ?? -3) != ContributionStatus.projectOwnerReject.rawValue || ($0.status ?? -3) != ContributionStatus.finished.rawValue
                }
            }
            .assign(to: \.contributions, on: self)
            .store(in: &cancellables)
        contributionRepository.getContributions(ownerId: currentUser)
    }
}
