//
//  MyContributionsViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 12/11/21.
//

import Combine
import FirebaseFirestore

class MyContributionsViewModel: ObservableObject {
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
