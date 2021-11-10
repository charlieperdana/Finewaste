//
//  AddContributionViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import Foundation

class AddContributionViewModel: ObservableObject {
    @Published var contributionModel = NewContributionModel()
    
    init(projectId: String) {
        self.contributionModel.postId = projectId
    }
    
    func postContribution() {
        
    }
}
