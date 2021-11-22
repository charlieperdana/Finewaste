//
//  HistoryContributionsViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 22/11/21.
//

import Combine


class HistoryContributionsViewModel: ObservableObject {
    private var repository = ContributionRepository()
    @Published var contributions = [Contribution]()
    
    var currentUser = AuthenticationHelper.shared.userId ?? ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        repository.$contributions
            .assign(to: \.contributions, on: self)
            .store(in: &cancellables)
        repository.getUserContribution(userID: currentUser)
    }
}
