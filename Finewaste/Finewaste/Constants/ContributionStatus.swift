//
//  ContributionStatus.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import Foundation

enum ContributionStatus: Int {
    case unknown = -3
    case wasteOwnerCancel = -2
    case projectOwnerReject = -1
    case waitingConfirmation = 0
    case confirmed = 1
    case deliverySet = 2
    case deliveryConfirmed = 3
    case waitingDelivery = 4
    case finished = 5
    
    init(from rawValue: Int) {
        self = ContributionStatus(rawValue: rawValue) ?? .unknown
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
}
