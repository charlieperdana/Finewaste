//
//  FinewasteContributionStatusCard.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI
import FirebaseFirestore

struct FinewasteContributionStatusCard: View {
    var id: String
    var projectName: String
    var user: String
    var createdDate: String
    
    var status: ContributionStatus = .unknown
    var statusInformation: String = ""
    var dueDate: String = ""
    
    private var statusInformationColor: Color {
        status == .finished ? Colors.Turqoise : Colors.Red
    }
    
    init(contribution: Contribution) {
        self.id = contribution.id ?? ""
        self.projectName = contribution.projectName ?? ""
        self.user = "---"
        self.createdDate = TimestampHelper.shared.timestampToStringDate(timestamp: contribution.createdDate ?? Timestamp(seconds: 0, nanoseconds: 0), format: .dateAndTime)
        
        let isOwner = AuthenticationHelper.shared.userId == (contribution.projectOwnerId ?? "")
        let deliveryType = contribution.deliveryType ?? ""
        if let contributionStatus = contribution.status {
            self.status = ContributionStatus(from: contributionStatus)
            
            if status == .waitingConfirmation {
                statusInformation = "Waiting confirmation until"
                if let createdDateTimestamp = contribution.createdDate {
                    let dueDateInThreeDays = Timestamp(seconds: Int64(createdDateTimestamp.seconds + 259200), nanoseconds: 0)
                    self.dueDate = TimestampHelper.shared.timestampToStringDate(timestamp: dueDateInThreeDays, format: .simple)
                }
            } else if status == .confirmed || status == .deliverySet {
                if (isOwner && deliveryType == "Drop off") || (!isOwner && deliveryType == "Pick up") {
                    statusInformation = "Waiting \(deliveryType.lowercased()) schedule"
                } else {
                    statusInformation = "Set \(deliveryType.lowercased()) schedule"
                }
            } else if status == .deliveryConfirmed {
                statusInformation = "\(deliveryType) at "
                if let deliveryDate = contribution.deliveryDate {
                    self.dueDate = TimestampHelper.shared.timestampToStringDate(timestamp: deliveryDate, format: .simple)
                }
            } else if status == .finished {
                statusInformation = "Contribution finished"
            } else if status <= .waitingConfirmation {
                statusInformation = "Contribution " + (status == .wasteOwnerCancel ? "cancelled" : "rejected")
            }
        }
    }
    
    var body: some View {
        NavigationLink(destination: ContributionStatusDetailView(contributionId: self.id)) {
            VStack(alignment: .leading) {
                HStack {
                    Text(projectName)
                        .font(Fonts.poppinsCallout())
                    Spacer()
                    if status == .waitingConfirmation {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Colors.Red)
                            .frame(width: 15, height: 15)
                    }
                }
                Spacer().frame(height: 0)
                HStack {
                    Text(user)
                        .font(Fonts.poppinsCaption())
                    Circle().frame(width: 4, height: 4)
                    Text(createdDate)
                        .font(Fonts.poppinsCaption())
                }
                Spacer().frame(height: 16)
                HStack(spacing: 3) {
                    Text(statusInformation)
                        .font(Fonts.poppinsCaption())
                    Text(dueDate)
                        .font(Fonts.poppinsCaption())
                        .bold()
                    Spacer()
                }
                .foregroundColor(statusInformationColor)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Colors.Gray, lineWidth: 1))
        }
    }
}

struct FinewasteContributionStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteContributionStatusCard(contribution: Contribution())
    }
}
