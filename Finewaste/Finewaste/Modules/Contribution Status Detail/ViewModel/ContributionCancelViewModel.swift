//
//  ContributionCancelViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 22/11/21.
//

import Foundation

class ContributionCancelViewModel: ObservableObject {
    private var repository = ContributionRepository()
    private var contributionId: String
    
    init(id: String) {
        self.contributionId = id
    }
    
    func archieveContribution() {
        var newData: [AnyHashable: Any] = [:]
        newData["archived"] = true
        
        self.repository.updateContribution(
            id: self.contributionId,
            newData: newData)
    }
}
