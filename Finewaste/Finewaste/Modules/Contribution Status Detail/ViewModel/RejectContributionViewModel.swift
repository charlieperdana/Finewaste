//
//  RejectContributionViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 21/11/21.
//

import Foundation

class RejectContributionViewModel: ObservableObject {
    private var repository = ContributionRepository()
    
    private var contributionId: String
    private var rejectionSide: RejectionSide
    
    init(contributionId: String, rejectionSide: RejectionSide) {
        self.contributionId = contributionId
        self.rejectionSide = rejectionSide
    }
    
    func rejectContribution(reason: String) {
        var newData: [AnyHashable: Any] = [:]
        if rejectionSide == .wasteOwner {
            newData["status"] = ContributionStatus.wasteOwnerCancel.rawValue
        } else {
            newData["status"] = ContributionStatus.projectOwnerReject.rawValue
        }
        newData["rejectionReason"] = reason
        newData["archived"] = false
        
        repository.rejectContribution(id: self.contributionId, newData: newData)
    }
}
