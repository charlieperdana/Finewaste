//
//  ContributionTimelineViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import Foundation

class ContributionTimelineViewModel: ObservableObject {
    private var contribution: Contribution
    
    private var deliveryType: String
    
    var status: ContributionStatus = .unknown
    
    var contributionRejectedHeaderText: String {
        if status == .projectOwnerReject {
            return "Contribution Rejected"
        } else {
            return "Contribution Cancelled"
        }
    }
    var contributionRejectedSubheaderText: String {
        if status == .projectOwnerReject {
            return "Sorry, your contribution request was rejected"
        } else {
            return "Sorry, your contribution request was cancelled"
        }
    }
    
    // MARK: - Computed properties for delivery confirmation part of timeline.
    var deliveryConfirmationDotStatus: TimelineStatus {
        if status < .deliveryConfirmed {
            return .incoming
        } else if status < .finished {
            return .current
        } else {
            return .completed
        }
    }
    var deliveryConfirmationHeaderText: String {
        if status < .waitingDelivery {
            return "\(deliveryType) Confirmation"
        } else if status == .finished {
            return "\(deliveryType.capitalized) Confirmed"
        } else {
            if !isProjectOwner {
                return deliveryType == "Pick up" ? "Prepare Your Contribution" : "Drop Off Your Contribution"
            } else {
                return deliveryType == "Pick up" ? "Confirm When Picked Up" : "Confirm When Dropped Off"
            }
        }
    }
    var deliveryConfirmationSubheaderText: String {
        if status < .deliveryConfirmed {
            return "Pending"
        } else if status == .finished {
            if !isProjectOwner {
                if deliveryType == "Drop off" {
                    return "Yay! your contribution drop off is confirmed"
                } else {
                    return "Yay! your contribution delivery is picked up"
                }
            } else {
                return "Yay! you already receive contribution!"
            }
        } else if status == .deliveryConfirmed {
            let otherSide = isProjectOwner ? "contributor" : "project owner"
            return "Chat \(otherSide) for \(deliveryType.lowercased()) details"
        } else {
            return "Yay! your contribution \(deliveryType.lowercased()) is confirmed"
        }
    }
    
    // MARK: - Computed properties for delivery schedule part of timeline.
    var deliveryScheduleDotStatus: TimelineStatus {
        if status < .confirmed {
            return .incoming
        } else if status < .deliveryConfirmed {
            return .current
        } else {
            return .completed
        }
    }
    var deliveryScheduleHeaderText: String {
        if status < .confirmed {
            return "\(deliveryType) Schedule"
        } else if status == .deliverySet {
            if (!isProjectOwner && deliveryType == "Drop off") || (isProjectOwner && deliveryType == "Pick up" ) {
                return "Confirm Delivery Schedule"
            } else {
                return "Waiting \(deliveryType.capitalized) Schedule"
            }
        } else if status == .confirmed {
            if isProjectOwner {
                return (deliveryType == "Drop off" ? "Waiting" : "Set") + (" \(deliveryType.capitalized) Schedule")
            } else {
                return (deliveryType == "Drop off" ? "Set" : "Waiting") + (" \(deliveryType.capitalized) Schedule")
            }
        } else {
            return "\(deliveryType) Scheduled"
        }
    }
    var deliveryScheduleSubheaderText: String {
        if status < .confirmed {
            return "Pending"
        } else if status == .confirmed {
            if (!isProjectOwner && deliveryType == "Drop off") || (isProjectOwner && deliveryType == "Pick up" ) {
                return "Set schedule within 3 days from now"
            } else {
                return "\(deliveryType) will scheduled within 3 days from now"
            }
        } else if status == .deliverySet {
            if (!isProjectOwner && deliveryType == "Drop off")  || (isProjectOwner && deliveryType == "Pick up" ) {
                return "\(deliveryType) at \(deliveryDate)"
            } else {
                return "\(deliveryType.capitalized) will scheduled within 3 days from now"
            }
        } else {
            return "\(deliveryType) at \(deliveryDate)"
        }
    }
    
    // MARK: - Computed properties for contribution confirmation part of timeline.
    var confirmationDotStatus: TimelineStatus {
        status > .waitingConfirmation ? .completed : .current
    }
    var confirmationHeaderText: String {
        if status > .waitingConfirmation {
            return "Contribution Confirmed"
        }
        
        return isProjectOwner ? "Confirm Contribution" : "Waiting for Confirmation"
    }
    var confirmationSubheaderText: String {
        var confirmationSubheaderText = ""
        
        if status == .waitingConfirmation {
            if let timestamp = contribution.createdDate {
                let timestampInThreeDays = TimestampHelper.shared.addThreeDaysTo(
                    timestamp: timestamp)
                let date = TimestampHelper.shared.timestampToStringDate(
                    timestamp: timestampInThreeDays,
                    format: .simple)
                
                if isProjectOwner {
                    confirmationSubheaderText = "Confirm before \(date)"
                } else {
                    confirmationSubheaderText = "Waiting confirmation until \(date)"
                }
            }
        } else {
            if isProjectOwner {
                confirmationSubheaderText = "Yay! you have new contributor"
            } else {
                confirmationSubheaderText = "Yay! your contribution request is confirmed"

            }
        }
        
        return confirmationSubheaderText
    }
    
    private var deliveryDate: String {
        if let deliveryDate = contribution.deliveryDate {
            return TimestampHelper.shared.timestampToStringDate(timestamp: deliveryDate, format: .dayDate)
        }
        
        return "---"
    }
    
    var isProjectOwner: Bool
    
    init(contribution: Contribution) {
        self.contribution = contribution
        self.deliveryType = (contribution.deliveryType ?? "")
        
        if let status = contribution.status {
            self.status = ContributionStatus(from: status)
        }
        
        if let ownerId = contribution.projectOwnerId {
            isProjectOwner = ownerId == AuthenticationHelper.shared.userId
        } else {
            isProjectOwner = false
        }
    }
}
