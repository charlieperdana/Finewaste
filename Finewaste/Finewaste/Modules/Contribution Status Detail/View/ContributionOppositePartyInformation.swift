//
//  ContributionOppositePartyInformation.swift
//  Finewaste
//
//  Created by Andrean Lay on 04/12/21.
//

import SwiftUI

struct ContributionOppositePartyInformation: View {
    private var currentUserIsOwner: Bool
    private var oppositePartyId: String
    private var oppositePartyUsername: String
    private var oppositePartyDisplayName: String
    private var oppositePartyPhotoUrl: String
    
    private var oppositePartyPosition: String {
        currentUserIsOwner ? "Contributor" : "Project Owner"
    }
    
    init(contribution: Contribution) {
        self.currentUserIsOwner = (contribution.projectOwnerId ?? "---") == AuthenticationHelper.shared.userId
        
        self.oppositePartyId = currentUserIsOwner ? (contribution.contributorId ?? "---") : (contribution.projectOwnerId ?? "---")
        self.oppositePartyUsername = currentUserIsOwner ? contribution.contributorUsername : contribution.projectOwnerUsername
        self.oppositePartyDisplayName = currentUserIsOwner ? contribution.contributorDisplayName : contribution.projectOwnerDisplayName
        self.oppositePartyPhotoUrl = currentUserIsOwner ? contribution.contributorPhotoUrl : contribution.projectOwnerPhotoUrl
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(oppositePartyPosition)
                    .font(Fonts.poppinsCallout())
                Text(oppositePartyUsername)
                    .font(Fonts.poppinsSubheadline())
            }
            Spacer()
            ChatButton(style: .small,
                       receiverId: oppositePartyId,
                       receiverName: oppositePartyDisplayName,
                       receiverPhotoUrl: oppositePartyPhotoUrl)
        }
    }
}

struct ContributionOppositePartyInformation_Previews: PreviewProvider {
    static var previews: some View {
        ContributionOppositePartyInformation(contribution: Contribution())
    }
}
