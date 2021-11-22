//
//  ContributionRejectionReasons.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import Foundation

struct ContributionRejection {
    static let ProjectOwner = ContributionSide(
        prompt: "Why do you want to reject the contribution?",
        title: "Reject Contribution",
        reasons: [
            "Materials does not meet the requirements",
            "Contributor can not be contacted",
            "Delivery problems",
            "Other reason"
        ]
    )
    
    static let WasteOwner = ContributionSide(
        prompt: "Why do you want to cancel the contribution?",
        title: "Cancel Contribution",
        reasons: [
            "I changed my mind",
            "Project owner can not be contacted",
            "Delivery problems",
            "Other reason"
        ]
    )
}

struct ContributionSide {
    var prompt: String
    var title: String
    var reasons: [String]
}
